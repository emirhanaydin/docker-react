FROM node:14-alpine as build

WORKDIR /home/node/app

COPY package.json .
COPY package-lock.json .

RUN npm install

COPY src/ src/
COPY public/ public/

RUN npm run build

FROM nginx

EXPOSE 80

COPY --from=build /home/node/app/build /usr/share/nginx/html
