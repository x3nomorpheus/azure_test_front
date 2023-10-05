FROM node:18-alpine
WORKDIR /react-docker/
COPY react-docker/public/ /react-docker/public
COPY react-docker/src/ /react-docker/src
COPY react-docker/package.json /react-docker/

RUN npm install
CMD ["npm", "start"]
