import os
import django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'djangoservice.settings')
django.setup()

from flask import Flask, jsonify, request
from flask_restful import Resource, Api
import flask_restful as restful

#SERVICE LAYER IMPORTS
from apis.controllers.abc import Abc
from apis.controllers.otp import Otp
from apis.controllers.login import Login
from apis.controllers.test import Test



app = Flask(__name__)

api = restful.Api(app, prefix='/travelapp/v1/')

# #API END POINTS
api.add_resource(Abc, 'abc/', 'abc/<string:id>')
api.add_resource(Otp, 'otp/', 'otp/<string:id>')
api.add_resource(Login, 'login/', 'login/<string:id>')
api.add_resource(Test, 'test/', 'test/<string:id>')

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8048, debug=True)