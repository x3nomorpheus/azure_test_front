FROM node:18-alpine
RUN apk --no-cache add curl
WORKDIR /react-docker/
COPY react-docker/public/ /react-docker/public
COPY react-docker/src/ /react-docker/src
COPY react-docker/package.json /react-docker/

RUN npm install
RUN npm test
CMD ["npm", "start"]
