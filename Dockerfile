#Download Node Alpine image
FROM node:16

#Setup the working directory
WORKDIR /app

#Copy package.json
COPY package.json package-lock.json ./

#Install dependencies
RUN npm install

RUN npm install -g @angular/cli@7.3.9

#Copy other files and folder to working directory
COPY . /app

# generate build
RUN ng build --output-path=dist

#Build Angular application in PROD mode
RUN npm run build

EXPOSE 80
EXPOSE 443

# start app
CMD ng serve --host 0.0.0.0
