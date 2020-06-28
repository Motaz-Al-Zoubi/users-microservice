FROM node:12.4.0 AS deps
ARG NPM_TOKEN
ENV NPM_TOKEN $NPM_TOKEN
ARG NODE_ENV
ENV NODE_ENV $NODE_ENV
WORKDIR /var/code
COPY package.json .
COPY .npmrc-example .npmrc
RUN npm install
ADD . /var/code

FROM node:12.4.0
WORKDIR /var/code
RUN apt-get update && apt-get install -y vim
COPY --from=deps /var/code /var/code
COPY ./config-example.js ./config.js
RUN chmod +x server.js
ENTRYPOINT ["./server.js"]
