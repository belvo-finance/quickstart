FROM node:13-alpine

COPY . /opt/belvo/

WORKDIR /opt/belvo/

RUN npm rebuild node-sass

RUN npm install

EXPOSE 8080

CMD ["npm", "run", "serve"]
