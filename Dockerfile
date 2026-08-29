FROM alpine:3.22 AS assets
WORKDIR /src
COPY css ./css
COPY js ./js
COPY images ./images
COPY fonts ./fonts
COPY build-assets.sh ./
RUN ./build-assets.sh /src /out

FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=assets /out/ /usr/share/nginx/html/

EXPOSE 80
