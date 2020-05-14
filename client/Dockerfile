FROM node:13-alpine

RUN apk add --no-cache --virtual .gyp \
        python \
        make \
        g++

COPY . /opt/belvo/

WORKDIR /opt/belvo/

RUN npm install

EXPOSE 8080

CMD ["npm", "run", "serve"]
