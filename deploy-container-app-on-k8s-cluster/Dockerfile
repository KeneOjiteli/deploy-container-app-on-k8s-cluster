# using node as base image
FROM node:17-alpine

# create a working directory called app inside container
WORKDIR /app

# copy package.json in my local machine's current directory to working directory of container
COPY package.json .

# run npm install to install dependencies
RUN npm install


COPY . .

EXPOSE 4000
# required for docker desktop port mapping

# Command to run node app
CMD ["node", "app.js"]