from flask_restful import Resource
from flask.globals import request

from utils.resource import BaseResource
from utils.response import error_response, ok_response

from validators.test import validate_post_data, validate_put_data  

class Test(BaseResource):
    def get(self, id=None):
        param_json = request.args.to_dict() 
        return error_response(401, [])


    def put(self, id=None):
        request_data = request.get_json(force=True) 

        errors = validate_put_data(request_data)
        if errors:
            return error_response(400, errors)

        return error_response(401, [])


    def post(self):
        request_data = request.get_json(force=True) 
        
        errors = validate_post_data(request_data)
        if errors:
            return error_response(400, errors)

        return error_response(401, [])


    def delete(self, id=None):
        return error_response(401, [])

