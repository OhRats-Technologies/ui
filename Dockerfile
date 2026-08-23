FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY css/ /usr/share/nginx/html/latest/
COPY js/ /usr/share/nginx/html/latest/
COPY images/logo.png /usr/share/nginx/html/latest/logo.png

EXPOSE 80
