# Stage 1: Build Angular app
FROM node:latest as build

WORKDIR /app

# Copy only package.json and package-lock.json for installing dependencies
COPY package.json yarn.lock ./

# Install all dependencies, including devDependencies, using yarn
RUN yarn install

# Copy the entire project and build the Angular app
COPY . .
RUN yarn run build --prod

# Stage 2: Serve Angular app with Nginx
FROM nginx:alpine

# Copy built Angular app from the build stage to Nginx
COPY --from=build /app/dist/crudtuto-Front /usr/share/nginx/html

EXPOSE 82

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]