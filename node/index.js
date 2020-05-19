const express = require("express");
const app = express();
const port = 5000;
const axios = require('axios');
const bodyParser = require('body-parser');
const moment = require('moment');
const belvo = require('belvo').default;

app.use(bodyParser.json());
app.use(function (req, res, next) {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');
    res.setHeader('Access-Control-Allow-Credentials', true);
    next();
});

// Fill in your Belvo API keys - https://dashboard.belvo.co
BELVO_SECRET_ID = process.env.BELVO_SECRET_ID
BELVO_SECRET_PASSWORD = process.env.BELVO_SECRET_PASSWORD
// Use `sandbox` to test with Belvo's Sandbox environment
// Use `production` to go live
BELVO_ENV = process.env.BELVO_ENV || 'sandbox'
BELVO_ENV_URL = process.env.BELVO_ENV === 'sandbox' ? 'https://sandbox.belvo.co' : 'https://api.belvo.co'

const client = new belvo(
    BELVO_SECRET_ID,
    BELVO_SECRET_PASSWORD,
    BELVO_ENV_URL
);

// Request an access token to be used when loading the Widget
// https://developers.belvo.co/docs/connect-widget#section--3-generate-an-access_token-
app.get("/get_token", (req, res, next) => {
    const data = {
        id: BELVO_SECRET_ID,
        password: BELVO_SECRET_PASSWORD,
        scopes: "read_institutions,write_links,read_links,delete_links"
    }

    const config = {
        auth: {
            username: BELVO_SECRET_ID,
            password: BELVO_SECRET_PASSWORD
        }
    }
    
    axios.post(`${BELVO_ENV_URL}/api/token/`, data, config)
        .then(response => {
            res.json(response.data);
        })
        .catch(error => {
            res.status(500).send({
                message: error.message
            });
        });
});

app.post("/accounts", (req, res, next) => {
    const { link_id } = req.body;
    client.connect()
        .then(() => {
            client.accounts.retrieve(link_id)
                .then((response) => {
                    res.json(response);
                })
                .catch(function (error) {
                    res.status(500).send({
                        message: error.message
                    });
                });
        });
});

app.post("/transactions", (req, res, next) => {
    const { link_id } = req.body;
    const date_from = moment().subtract(30, "days").format('YYYY-MM-DD');
    const date_to = moment().format('YYYY-MM-DD');

    client.connect()
        .then(function () {
            client.transactions.retrieve(link_id, date_from, { dateTo: date_to })
                .then((response) => {
                    res.json(response);
                })
                .catch((error) => {
                    console.log('error', error)
                    res.status(500).send({
                        message: error.message
                    });
                });
        });
});


app.post("/balances", (req, res, next) => {
    const { link_id } = req.body;
    const date_from = moment().subtract(30, "days").format('YYYY-MM-DD');
    const date_to = moment().format('YYYY-MM-DD');

    client.connect()
        .then(function () {
            client.balances.retrieve(link_id, date_from, { dateTo: date_to })
                .then((response) => {
                    res.json(response);
                })
                .catch((error) => {
                    console.log('error', error)
                    res.status(500).send({
                        message: error.message
                    });
                });
        });
});

app.post("/owners", (req, res, next) => {
    const { link_id } = req.body;

    client.connect()
        .then(function () {
            client.owners.retrieve(link_id)
                .then((response) => {
                    res.json(response);
                })
                .catch((error) => {
                    console.log('error', error)
                    res.status(500).send({
                        message: error.message
                    });
                });
        });
});


app.listen(port, () => console.log(`Server running on port ${port}!`))
