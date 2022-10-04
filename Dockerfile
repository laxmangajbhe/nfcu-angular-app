#Download Node Alpine image
FROM node:alpine as builder

#Setup the working directory
WORKDIR /usr/src/app

#Copy package.json
COPY package.json package-lock.json ./

#Install dependencies
RUN npm install

RUN npm install -g @angular/cli

#Copy other files and folder to working directory
COPY . .

# generate build
RUN ng build --output-path=dist/nfcu-angular-app

#Build Angular application in PROD mode
#RUN npm run build

#EXPOSE 4200

# Second Stage Without NGINX
 
#WORKDIR /usr/src/app/dist/nfcu-angular-app
#CMD ng serve --host 0.0.0.0 

# Container App
# Second Stage (With NGINX)

# nginx state for serving content
FROM nginx:alpine
# Set working directory to nginx asset directory
WORKDIR /usr/share/nginx/html
# Remove default nginx static assets
RUN rm -rf ./*
# Copy static assets from builder stage
COPY --from=builder /usr/src//app/dist/nfcu-angular-app .
# Containers run nginx with global directives and daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"]


