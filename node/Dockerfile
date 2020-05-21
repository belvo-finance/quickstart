FROM node:10

WORKDIR /opt/belvo/

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 5000

CMD [ "node", "index.js" ]