import flask_restful as restful

class BaseResource(restful.Resource):
    method_decorators = []


    def options(self, *args, **kwargs):
        return {"status": "OPTIONS OK"}