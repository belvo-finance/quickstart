# Quickstart for belvo-python

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/belvo-finance/quickstart/tree/master/python)

To run this application locally, first install it and then run the app with the instructions below.

## Installing the quickstart app

```
git clone https://github.com/belvo-finance/quickstart.git
cd quickstart/python

pip install -r requirements.txt

cd client
npm install
cd ..
```

## Run the backend
```
# Start the Quickstart app with your sandbox API keys from the Dashboard
# https://dashboard.belvo.co/

BELVO_SECRET_ID='BELVO_SECRET_ID' \
BELVO_SECRET_PASSWORD='BELVO_SECRET_PASSWORD' \
BELVO_ENV=sandbox \
python server.py
```

## Run the client
```
cd client
npm run serve

# Configure the widget to Belvo by adding your private
# IP and the port as a new URL in the Connect Widget 
# area (e.g: 192.139.199.12:8080)
# https://dashboard.belvo.co/configuration/widget/
```

## Create a link
The quickstart app is using the `Sandbox` environment by default.

**You can use any combination of username and password to create a link with an institution in `Sandbox`.**

Read more about creating links in sandbox in our [dedicated guide](https://developers.belvo.co/docs/test-in-sandbox#create-links-in-sandbox).
