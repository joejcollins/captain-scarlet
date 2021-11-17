""" Flask App """
import os
import flask
import flasgger
import flasgger.utils as swag_utils
import flask_app_apidocs as apidocs
from UnleashClient import UnleashClient

api = flask.Flask(__name__)

UNLEASH_URL = os.environ.get('UNLEASH_URL')
UNLEASH_API_TOKEN = os.environ.get('UNLEASH_API_TOKEN')

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
        'message': "Hello there",
        'docs': '/apidocs/'
    }
    feature = UnleashClient(
        url=UNLEASH_URL,
        app_name="default",
        custom_headers={'Authorization': UNLEASH_API_TOKEN})
    feature.initialize_client()
    if feature.is_enabled("ops-test-toggle"):
        greeting['message'] = "Hello toggle"
    feature.destroy()
    return flask.jsonify(greeting)
