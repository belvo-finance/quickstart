# Quickstart for belvo-ruby

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/belvo-finance/quickstart/tree/master/ruby)

To run this application locally, first install it and then run the app with the instructions below.

## Installing the quickstart app

``` bash
git clone https://github.com/belvo-finance/quickstart.git
cd quickstart/ruby
# Install dependencies
bundle
```

## Run the backend
``` bash
# Start the Quickstart app with your sandbox API keys from the Dashboard
# https://dashboard.belvo.co/

BELVO_SECRET_ID='BELVO_SECRET_ID' \
BELVO_SECRET_PASSWORD='BELVO_SECRET_PASSWORD' \
BELVO_ENV=sandbox \
ruby app.rb
```
