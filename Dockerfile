#Download Node Alpine image
FROM node:alpine

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

EXPOSE 4200

#FROM nginx:alpine
#COPY --from=node /app/dist/nfcu-angular-app /usr/share/nginx/html
# start app
WORKDIR /usr/src/app/dist/nfcu-angular-app
CMD ng serve --host 0.0.0.0
