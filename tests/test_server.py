from flask import url_for


def test_get_token(client):
    response = client.get(url_for("get_token"))
    assert response.status_code == 200


def test_retrieve_accounts(client):
    response = client.post(url_for("retrieve_accounts"), json={})
    assert response.status_code == 200
