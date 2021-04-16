# Node environment to run Javascript apps eg React
FROM node:13.12.0-alpine as build

WORKDIR .

# Copy dependencies to docker
COPY . .
# Run This to install all the dependencies in package.json
RUN npm install
# Build react application for production /build
RUN npm audit fix
RUN npm run build


# production environment
FROM nginx:1.19.9-alpine

COPY --from=build /build /usr/share/nginx/html

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx/nginx.conf /etc/nginx/conf.d

# COPY --from=build /react-image-compressor/nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
