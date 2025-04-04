pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
        IMAGE_NAME = 'imassenda/web-app'
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        // CI (Continuous Integration)
        stage('build') {
            steps {
                echo 'Cloner le projet et construire une image Docker de l\'application'
                bat 'docker build -t %IMAGE_NAME%:%IMAGE_TAG% .'
            }
        }
        
        stage('test') {
            steps {
                echo 'Test de l\'image Docker'
                bat '''
                    docker run -d -p 8085:80 --name test-container %IMAGE_NAME%:%IMAGE_TAG%
                    timeout /t 5
                    powershell -Command "if ((Invoke-WebRequest -Uri http://localhost:8085).Content -notmatch 'Welcome') { exit 1 }"
                    docker stop test-container
                    docker rm test-container
                '''
            }
        }
        
        stage('release') {
            steps {
                echo 'Publication de l\'image sur Docker Hub'
                bat '''
                    echo %DOCKER_HUB_CREDENTIALS_PSW% | docker login -u %DOCKER_HUB_CREDENTIALS_USR% --password-stdin
                    docker push %IMAGE_NAME%:%IMAGE_TAG%
                    docker tag %IMAGE_NAME%:%IMAGE_TAG% %IMAGE_NAME%:latest
                    docker push %IMAGE_NAME%:latest
                '''
            }
        }
        
        // CD (Continuous Deployment)
        stage('Deploy in Review') {
            steps {
                echo 'Déploiement en environnement de revue'
                withCredentials([sshUserPrivateKey(credentialsId: 'aws-review-ssh-key', keyFileVariable: 'SSH_KEY')]) {
                    bat '''
                        powershell -Command "ssh -i \"%SSH_KEY%\" -o StrictHostKeyChecking=no ubuntu@16.171.1.77 \"docker pull %IMAGE_NAME%:%IMAGE_TAG% && docker stop review-container || true && docker rm review-container || true && docker run -d -p 80:80 --name review-container %IMAGE_NAME%:%IMAGE_TAG%\""
                    '''
                }
            }
        }
        
        stage('Deploy in Staging') {
            steps {
                echo 'Déploiement en environnement de préproduction'
                withCredentials([sshUserPrivateKey(credentialsId: 'aws-staging-ssh-key', keyFileVariable: 'SSH_KEY')]) {
                    bat '''
                        powershell -Command "ssh -i \"%SSH_KEY%\" -o StrictHostKeyChecking=no ubuntu@51.21.181.0 \"docker pull %IMAGE_NAME%:%IMAGE_TAG% && docker stop staging-container || true && docker rm staging-container || true && docker run -d -p 80:80 --name staging-container %IMAGE_NAME%:%IMAGE_TAG%\""
                    '''
                }
            }
        }
        
        stage('Deploy in Production') {
            steps {
                echo 'Déploiement en environnement de production'
                withCredentials([sshUserPrivateKey(credentialsId: 'aws-production-ssh-key', keyFileVariable: 'SSH_KEY')]) {
                    bat '''
                        powershell -Command "ssh -i \"%SSH_KEY%\" -o StrictHostKeyChecking=no ubuntu@13.60.12.219 \"docker pull %IMAGE_NAME%:%IMAGE_TAG% && docker stop production-container || true && docker rm production-container || true && docker run -d -p 80:80 --name production-container %IMAGE_NAME%:%IMAGE_TAG%\""
                    '''
                }
            }
        }
    }
}