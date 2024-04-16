FROM node:16-alpine
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install -g @angular/cli
RUN npm i
COPY . .
RUN ng build
RUN npm i -g serve
EXPOSE 82 
CMD [ "serve", "-S" , "dist/my-app-angular"]
