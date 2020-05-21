# Quickstart for belvo-python

To run this application locally, first install it and then run the app with the instructions below.

## Installing the Node.js app

```
git clone https://github.com/belvo-finance/quickstart.git
cd quickstart/node

npm install
```

## Run the backend
```
# Start the Quickstart app with your sandbox API keys from the Dashboard
# https://dashboard.belvo.co/

BELVO_SECRET_ID='BELVO_SECRET_ID' \
BELVO_SECRET_PASSWORD='BELVO_SECRET_PASSWORD' \
BELVO_ENV=sandbox \
node index.js
```
