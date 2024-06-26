#!/bin/bash

RESOURCE_NAME=$1 
RESOURCE_NAME_LOWER=${RESOURCE_NAME,,}


echo "from flask_restful import Resource
from flask.globals import request

from utils.resource import BaseResource
from utils.response import error_response, ok_response

from validators.ResourceLower import validate_post_data, validate_put_data  

class ResourceName(BaseResource):
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
" | sed -r 's/ResourceName/'$RESOURCE_NAME'/' | sed -r 's/ResourceLower/'$RESOURCE_NAME_LOWER'/' > apis/controllers/$RESOURCE_NAME_LOWER.py 


echo "from jsonschema import Draft4Validator

ResourceLower_post_schema = {
}

ResourceLower_put_schema = {
}


v_post = Draft4Validator(ResourceLower_post_schema)
v_put = Draft4Validator(ResourceLower_put_schema)


def validate_post_data(request_data):
    return [{ 
            'field': 'non_field_error',
            'code': 1000,
            'client_message': x.message,
            'server_message': x.message
        } for x in v_post.iter_errors(request_data)]


def validate_put_data(request_data):
    return [{ 
            'field': 'non_field_error',
            'code': 1000,
            'client_message': x.message,
            'server_message': x.message
        } for x in v_put.iter_errors(request_data)]
" | sed -r 's/ResourceName/'$RESOURCE_NAME'/' | sed -r 's/ResourceLower/'$RESOURCE_NAME_LOWER'/' > validators/$RESOURCE_NAME_LOWER.py


SERVICE_REPLACEMENT="api.add_resource("$RESOURCE_NAME", '"$RESOURCE_NAME_LOWER"/', '"$RESOURCE_NAME_LOWER"/<string:id>')"
IMPORT_STRING_REPLACEMENT="from apis.controllers."$RESOURCE_NAME_LOWER" import "$RESOURCE_NAME


sed -i "s|#API END POINTS|#API END POINTS\n$SERVICE_REPLACEMENT|g" service.py
sed -i "s|#SERVICE LAYER IMPORTS|#SERVICE LAYER IMPORTS\n$IMPORT_STRING_REPLACEMENT|g" service.py

