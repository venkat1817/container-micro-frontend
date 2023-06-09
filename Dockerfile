# FROM reactjs 
# WORKDIR /build 
# COPY . /build 
# CMD ['npm start']

# FROM node:alpine AS build_stage
# WORKDIR '/app'
# COPY package.json .
# RUN npm install
# COPY . .
# RUN npm run build

# FROM nginx
# COPY --from=build_stage /app/build /usr/share/nginx/html


FROM node:alpine AS build_stage
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve the built files using Nginx
FROM nginx
COPY --from=build_stage /app/build /usr/share/nginx/html

# Add custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf



