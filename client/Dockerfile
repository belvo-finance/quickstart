FROM node:13.8-alpine3.11

COPY . /opt/belvo/

WORKDIR /opt/belvo/

RUN npm install

EXPOSE 8080

CMD ["npm", "run", "serve"]
