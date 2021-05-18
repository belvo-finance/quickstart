import json
import os
from datetime import datetime, timedelta

import urllib3
from belvo.client import Client
from belvo.exceptions import RequestError
from flask import Flask, jsonify, render_template, request
from flask_cors import CORS

# Fill in your Belvo API keys - https://dashboard.belvo.com
BELVO_SECRET_ID = os.getenv("BELVO_SECRET_ID")
BELVO_SECRET_PASSWORD = os.getenv("BELVO_SECRET_PASSWORD")
# Use `sandbox` to test with Belvo's Sandbox environment
# Use `production` to go live
# Use `development` to test with real data
BELVO_ENV = os.getenv("BELVO_ENV", "sandbox")

if BELVO_ENV == "production":
    BELVO_ENV_URL = "https://api.belvo.com"
elif BELVO_ENV == "development":
    BELVO_ENV_URL = "https://development.belvo.com"
else:
    BELVO_ENV_URL = "https://sandbox.belvo.com"

app = Flask(__name__, static_folder="./dist", template_folder="./dist")

CORS(app)

if BELVO_ENV == "sandbox" or BELVO_ENV == "development":
    app.config["TESTING"] = True
    os.environ["FLASK_ENV"] = "development"

client = Client(BELVO_SECRET_ID, BELVO_SECRET_PASSWORD, BELVO_ENV_URL)

# Disable warnings for unverified HTTPS requests
urllib3.disable_warnings()


@app.route("/", defaults={"path": ""})
def catch_all(path):
    return render_template("index.html")


# Request an access token to be used when loading the Widget
# https://developers.belvo.co/docs/connect-widget#section--3-generate-an-access_token-
@app.route("/get_token", methods=["GET"])
def get_token():
    try:
        response = client.WidgetToken.create()
    except RequestError as e:
        return jsonify(format_error(e))

    pretty_print_response(response)
    return jsonify(response)


@app.route("/accounts", methods=["POST"])
def retrieve_accounts():
    try:
        response = client.Accounts.create(link=request.json["link_id"])

    except RequestError as e:
        return jsonify(format_error(e))

    pretty_print_response(response)
    return jsonify(response)


@app.route("/transactions", methods=["POST"])
def retrieve_transactions():
    try:
        response = client.Transactions.create(
            link=request.json["link_id"],
            date_from=datetime.strftime(datetime.now() - timedelta(days=30), "%Y-%m-%d"),
            date_to=datetime.strftime(datetime.now(), "%Y-%m-%d"),
        )

    except RequestError as e:
        return jsonify(format_error(e))

    pretty_print_response(response)
    return jsonify(response)


@app.route("/balances", methods=["POST"])
def retrieve_balance():
    try:
        response = client.Balances.create(
            link=request.json["link_id"],
            date_from=datetime.strftime(datetime.now() - timedelta(days=30), "%Y-%m-%d"),
            date_to=datetime.strftime(datetime.now(), "%Y-%m-%d"),
        )

    except RequestError as e:
        return jsonify(format_error(e))

    pretty_print_response(response)
    return jsonify(response)


@app.route("/owners", methods=["POST"])
def retrieve_owners():
    try:
        response = client.Owners.create(link=request.json["link_id"],)

    except RequestError as e:
        return jsonify(format_error(e))

    pretty_print_response(response)
    return jsonify(response)


@app.route("/statements", methods=["POST"])
def retrieve_statements():
    try:
        response = client.Statements.create(link=request.json["link_id"],)

    except RequestError as e:
        return jsonify(format_error(e))

    pretty_print_response(response.json())
    return jsonify(response.json())


def pretty_print_response(response):
    print(json.dumps(response, indent=2, sort_keys=True))


def format_error(e):
    return {
        "error": {
            "display_message": e.display_message,
            "error_code": e.code,
            "error_type": e.type,
            "error_message": e.message,
        }
    }


if __name__ == "__main__":
    app.run(port=os.getenv("PORT", 5000))
