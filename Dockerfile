FROM node:10.15.3 as source
WORKDIR /src/build-your-own-radar
COPY package.json ./
RUN npm install
COPY . ./
ARG CLIENT_ID
ENV CLIENT_ID=$CLIENT_ID
ARG API_KEY
ENV API_KEY=$API_KEY
RUN npm run build

FROM nginx:1.15.9
WORKDIR /opt/build-your-own-radar
COPY --from=source /src/build-your-own-radar/dist .
COPY default.template /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]