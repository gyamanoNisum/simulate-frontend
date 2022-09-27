FROM node as build-deps
WORKDIR /usr/src/app
COPY package.json ./
COPY . ./
RUN npm install --save react react-dom react-router-dom react-scripts
RUN npm run build

FROM nginx:1.12-alpine
COPY --from=build-deps /usr/src/app/build /usr/share/nginx/html/
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
