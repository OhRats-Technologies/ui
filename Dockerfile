FROM alpine:3.22 AS assets
WORKDIR /src
COPY css ./css
COPY js ./js
COPY images ./images
COPY build-assets.sh ./
RUN ./build-assets.sh /src /out

FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=assets /out/assets/ /usr/share/nginx/html/assets/
COPY --from=assets /out/current/ /usr/share/nginx/html/current/
COPY --from=assets /out/latest/ /usr/share/nginx/html/latest/

EXPOSE 80
