import os
import json
from flask import Flask
from flask import request
from flask import jsonify
from flask import render_template
from flask_cors import CORS
from belvo.client import Client
from belvo.exceptions import RequestError
import requests
from requests.auth import HTTPBasicAuth
from datetime import datetime, timedelta
import urllib3

app = Flask(__name__,
        static_folder = "./dist",
        template_folder = "./dist")

CORS(app)

# Fill in your Belvo API keys - https://dashboard.belvo.co
BELVO_SECRET_ID = os.getenv('BELVO_SECRET_ID')
BELVO_SECRET_PASSWORD = os.getenv('BELVO_SECRET_PASSWORD')
# Use `sandbox` to test with Belvo's Sandbox environment
# Use `production` to go live
BELVO_ENV = os.getenv('BELVO_ENV', 'sandbox')
BELVO_ENV_URL = 'https://sandbox.belvo.co' if BELVO_ENV == 'sandbox' else 'https://api.belvo.co'

client = Client(BELVO_SECRET_ID, BELVO_SECRET_PASSWORD, BELVO_ENV_URL)

# Disable warnings for unverified HTTPS requests
urllib3.disable_warnings()

@app.route('/', defaults={'path': ''})
def catch_all(path):
    return render_template("index.html")

# Request an access token to be used when loading the Widget
# https://developers.belvo.co/docs/connect-widget#section--3-generate-an-access_token-
@app.route('/get_token', methods=['GET'])
def get_token():
    try:
        url = BELVO_ENV_URL + '/api/token/'
        response = requests.post(url, verify=False, auth=HTTPBasicAuth(BELVO_SECRET_ID, BELVO_SECRET_PASSWORD),
                                 json={"id": BELVO_SECRET_ID, "password": BELVO_SECRET_PASSWORD,
                                       "scopes": "read_institutions,write_links,read_links,delete_links"})
    except RequestError as e:
        return jsonify(format_error(e))

    pretty_print_response(response.json())
    return jsonify(response.json())


@app.route('/accounts', methods=['POST'])
def retrieve_accounts():
    try:
        response = client.Accounts.create(
            link=request.json['link_id']
        )

    except RequestError as e:
        return jsonify(format_error(e))

    pretty_print_response(response)
    return jsonify(response)


@app.route('/transactions', methods=['POST'])
def retrieve_transactions():
    try:
        response = client.Transactions.create(
            link=request.json['link_id'],
            date_from=datetime.strftime(datetime.now() - timedelta(days=30), '%Y-%m-%d'),
            date_to=datetime.strftime(datetime.now(), '%Y-%m-%d')
        )

    except RequestError as e:
        return jsonify(format_error(e))

    pretty_print_response(response)
    return jsonify(response)


@app.route('/balances', methods=['POST'])
def retrieve_balance():
    try:
        response = client.Balances.create(
            link=request.json['link_id'],
            date_from=datetime.strftime(datetime.now() - timedelta(days=30), '%Y-%m-%d'),
            date_to=datetime.strftime(datetime.now(), '%Y-%m-%d')
        )

    except RequestError as e:
        return jsonify(format_error(e))

    pretty_print_response(response)
    return jsonify(response)


@app.route('/owners', methods=['POST'])
def retrieve_owners():
    try:
        response = client.Owners.create(
            link=request.json['link_id'],
        )

    except RequestError as e:
        return jsonify(format_error(e))

    pretty_print_response(response.json())
    return jsonify(response.json())


@app.route('/statements', methods=['POST'])
def retrieve_statements():
    try:
        response = client.Statements.create(
            link=request.json['link_id'],
        )

    except RequestError as e:
        return jsonify(format_error(e))

    pretty_print_response(response.json())
    return jsonify(response.json())

def pretty_print_response(response):
    print(json.dumps(response, indent=2, sort_keys=True))


def format_error(e):
    return {'error': {'display_message': e.display_message, 'error_code': e.code, 'error_type': e.type,
                      'error_message': e.message}}


if __name__ == '__main__':
    app.run(port=os.getenv('PORT', 5000))
