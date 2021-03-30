import pytest

from server import app as _app


@pytest.fixture
def client(app):
    return app.test_client()


@pytest.fixture
def app():
    with _app.app_context():
        yield _app
