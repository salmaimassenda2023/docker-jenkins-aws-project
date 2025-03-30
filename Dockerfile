# l image de base
FROM nginx
# Expose le port 80 pour accéder à l'application
EXPOSE 80
# Suppression des fichiers HTML par défaut de Nginx
RUN rm -rf /usr/share/nginx/html/*
# Definir /usr/share/nginx/html comme repertoitre de travail
WORKDIR /usr/share/nginx/html
# Copier tout le contenu du répertoire local dans le conteneur
COPY . .
# lancer nginx 
CMD ["nginx", "-g", "daemon off;"]




