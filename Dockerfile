FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY css/ /usr/share/nginx/html/latest/
COPY js/ /usr/share/nginx/html/latest/
COPY images/ /usr/share/nginx/html/latest/

EXPOSE 80
