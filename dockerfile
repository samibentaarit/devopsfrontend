# Use an official Node.js runtime as the base image
FROM node:latest as builder
# Set the working directory in the container
WORKDIR /app
# Copy package.json and package-lock.json to the working directory
COPY package*.json ./
# Set NODE_OPTIONS before npm install
ENV NODE_OPTIONS=--openssl-legacy-provider
# Install Angular CLI globally
RUN npm install -g @angular/cli
# Install dependencies
RUN npm install --force
# Copy the entire project to the working directory
COPY . .
# Build the Angular app
RUN ng build
# Use Nginx as a web server
FROM nginx:alpine

# Copy the built Angular app
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]