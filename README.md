# Belvo quickstart

In this repository you will find an example of an app that allows you to link bank accounts through Belvo’s API using our widget. Once an account is linked, you can access the detailed information about the Accounts, Transactions and Owners.

You can access all the app code and reuse it for you application.

Quickstart is currently available for [Python](https://github.com/belvo-finance/quickstart/tree/master/python), [Ruby](https://github.com/belvo-finance/quickstart/tree/master/ruby) and [Node](https://github.com/belvo-finance/quickstart/tree/master/node). 

Coming soon: `Go`, `Java`.

![Belvo quickstart app](/assets/quickstart-screenshot.png)

## Requirements

* Docker 19+
* docker-compose 1.25+
* GNU Make
* A valid Belvo secret key

## Getting started

### 1. Clone the repository
```
git clone https://github.com/belvo-finance/quickstart.git
cd quickstart/
```

### 2. Setup the Quickstart app
Setup the Quickstart app with your sandbox API keys from the Dashboard (https://dashboard.belvo.co/)
```
echo "BELVO_SECRET_ID=[YOUR_ID_HERE]
BELVO_SECRET_PASSWORD=[YOUR_PASSWORD_HERE]
# You can choose between sandbox and production
BELVO_ENV=sandbox
# You can choose between python, ruby or node
CONTEXT=python" >> .env
```

### 3. Configure the widget
Configure the widget by adding your local URL in the Connect Widget area:
- Go to https://dashboard.belvo.co/configuration/widget/
- Add `http://localhost:8080` to the list of URLs

### 4. Run the application

```
make run
```


## About Belvo

Learn more about Belvo: 
- [Developers portal](https://developers.belvo.co/)
- [API reference](https://docs.belvo.co/)
- [Help Center](https://support.belvo.co/hc/en-us)
- [Belvo libraries](https://github.com/belvo-finance/)
