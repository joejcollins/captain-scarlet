""" Flask App """
import os
import flask
import flasgger
import flasgger.utils as swag_utils
import flask_app_apidocs as apidocs
from UnleashClient import UnleashClient
from flask_unleash import Unleash

UNLEASH_URL = os.environ.get('UNLEASH_URL')
UNLEASH_API_TOKEN = os.environ.get('UNLEASH_API_TOKEN')

api = flask.Flask(__name__)
api.config["UNLEASH_URL"] = UNLEASH_URL
api.config["UNLEASH_APP_NAME"] = "default"
api.config["UNLEASH_CUSTOM_HEADERS"] = {'Authorization': UNLEASH_API_TOKEN}
api.config["UNLEASH_ENVIRONMENT"] = "default"
unleash = Unleash(api)

swagger_template = {
    "swagger": "2.0",
    "info": {
        "title": "Celery Demo API",
        "description": "Demo of Flask and Celery in action.",
        "version": "0.0.1"
    },
    "basePath": "/"
}
swagger = flasgger.Swagger(api, template=swagger_template)


@api.route('/', methods=['GET'])
@swag_utils.swag_from(apidocs.INDEX)
def index():
    """ Confirm that the flask app is running. """
    greeting = {
        'message': "Hello there, no toggle.",
        'docs': '/apidocs/'
    }
    feature = UnleashClient(
        url=UNLEASH_URL,
        app_name="default",
        custom_headers={'Authorization': UNLEASH_API_TOKEN})
    feature.initialize_client()
    if feature.is_enabled("ops-test-toggle"):
        greeting['message'] = "Hello we be toggling."
    feature.destroy()
    return flask.jsonify(greeting)


@api.route('/test', methods=['GET'])
def test():
    """ Return a message with a better look to it. """
    if unleash.client.is_enabled("ops-test-toggle"):
        message = "It's on"
    else:
        message = "Get orf"
    return flask.jsonify(message)
