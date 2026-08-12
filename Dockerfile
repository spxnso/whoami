# build
FROM ghcr.io/getzola/zola:v0.22.1 AS zola

COPY . /project
WORKDIR /project

RUN ["zola", "build"]

# serve
FROM ghcr.io/static-web-server/static-web-server:2

COPY --from=zola /project/public /public

ENV SERVER_ROOT=/public
ENV SERVER_PORT=80
ENV SERVER_IGNORE_HIDDEN_FILES=false
ENV SERVER_HEALTH=true

EXPOSE 80