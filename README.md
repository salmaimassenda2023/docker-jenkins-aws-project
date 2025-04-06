# 🚀 Déploiement Automatisé d'une Application Web avec Jenkins & AWS (CI/CD)

## 📌 Réalisé par                                                                      
- **Imassenda Salma**
- **Boumour Marwa**
- **Yosra El Mimouni**

## 🎯 Objectif du Projet

Mettre en place un pipeline CI/CD complet pour automatiser le **build**, les **tests**, le **push Docker** et le **déploiement** d’une application web statique via **Jenkins** et **AWS**.

- **CI (Continuous Integration)** : Build, Test, Push sur Docker Hub.
- **CD (Continuous Deployment)** : Déploiement automatique sur 3 environnements AWS :
  - `review`
  - `staging`
  - `production`

---

## 🛠️ Stack Utilisée

- **Docker**
- **Jenkins**
- **GitHub**
- **AWS EC2**
- **Docker Hub**
-  PowerShell (agent Jenkins sur Windows)
- Authentification SSH
- Nginx (pour servir l’application statique)

---

## 📁 Structure du Projet

- **Jenkinsfile** : Contient les étapes de la pipeline CI/CD : Build, Test, Release et Deploy.
- **Dockerfile** : Permet de construire l’image Docker de l’application.
- **Dépôt GitHub** : Contient le code source et la configuration de la pipeline.
- **Serveurs EC2** :
  - Environnements : `Revue`, `Préproduction`, `Production`.
- **DockerHub** : Héberge les images Docker utilisées pour le déploiement.

---

## 🧩 Étapes du Projet

### 1. Création de l’Application Web

- Application web statique créée et conteneurisée à l’aide d’un `Dockerfile`.
- Port utilisé : `8085:80`.

### 2. Dockerisation

- Écriture du `Dockerfile`.
- Build de l’image : `docker build -t imassenda/web-app:tag .`
- Test de l’image localement.
- Push automatique vers Docker Hub via Jenkins.

### 3. Dépôt GitHub

- Code source + Jenkinsfile poussés dans un dépôt GitHub.

### 4. Configuration AWS EC2

- Création de 3 instances EC2 :
  - `review-instance`
  - `staging-instance`
  - `production-instance`
- Ouverture des ports :
  - SSH (`22`) pour la connexion distante
  - HTTP (`80`) pour accéder à l’application via navigateur
- Installation de Docker sur chaque instance.

### 5. Configuration Jenkins

- Création d’un `Jenkinsfile` pour automatiser le pipeline.
- Création de 3 clés SSH pour l'accès aux 3 serveurs.
- Configuration des identifiants Jenkins pour accéder à Docker Hub.
- Ajout et configuration des plugins Docker dans Jenkins.

---

## ⚙️ Pipeline CI/CD avec Jenkins

```plaintext
[Build] → Construire l’image Docker
[Test] → Tester l’image (container + requête HTTP)
[Release] → Push de l’image sur Docker Hub (tagged)
[Deploy] → Déploiement automatique sur les 3 serveurs EC2 
```

---

## 📣 🔥 À ne pas manquer !

### 📄 Rapport détaillé du projet

🟡 Un rapport complet est disponible et contient toutes les étapes du projet, les configurations techniques, les problèmes rencontrés ainsi que leurs solutions.

🔗 **Lien vers le rapport** :  
👉 📂 [Accéder au rapport complet sur Google Drive](https://drive.google.com/drive/folders/10pY_FMxSgpowM6ydKoKTLt24wj-PW2sP?usp=drive_link)

⚠️ **Merci de bien vouloir consulter ce document lors de l’évaluation, il est essentiel pour comprendre le déroulement et les choix techniques du projet.**

---
