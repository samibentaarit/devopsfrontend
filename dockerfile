# Stage 1: Build the Angular app
FROM node:14 as builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build --prod

# Stage 2: Serve the Angular app using NGINX
FROM nginx:alpine

COPY --from=builder /app/dist/* /usr/share/nginx/html/

EXPOSE 82

CMD ["nginx", "-g", "daemon off;"]
