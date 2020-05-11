# Belvo quickstart

In this repository you will find an example of an app that allows you to link bank accounts through Belvo’s API using our widget. Once an account is linked, you can access the detailed information about the Accounts, Transactions and Owners.

You can access all the app code and reuse it for you application.

Quickstart is currently available for [Python](https://github.com/belvo-finance/quickstart/tree/master/python). 

Coming soon: `Node`, `Ruby`, `Go`, `Java`.

![Belvo quickstart app](/assets/quickstart-screenshot.png)

## Requirements

* Docker 19+
* docker-compose 1.25+
* GNU Make
* A valid Belvo secret key

## Getting started
Copy the `.env.example` file included in this project and name it `.env`. 

Using your text editor of choice open the `.env` file and complete the info, now you just need to open a terminal and execute:
```bash
$> make run
```

Learn more about Belvo: 
- [Developers portal](https://developers.belvo.co/)
- [API reference](https://docs.belvo.co/)
- [Help Center](https://support.belvo.co/hc/en-us)
- [Belvo libraries](https://github.com/belvo-finance/)
