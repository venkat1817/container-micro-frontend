# FROM reactjs
# WORKDIR /build
# COPY ./build
# # EXPOSE 80
# CMD ['npm start']

FROM node:alpine AS build_stage
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=build_stage /app/build /usr/share/nginx/html

