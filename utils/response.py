headers_mapping = {'csv': {'content-type': 'application/csv'},
                   'json': {'content-type': 'application/json'}}


def ok_response(response, headers='json', http_status=200):
    return response, http_status, headers_mapping[headers]


def error_response(http_status, errors, headers='json'):
    return errors, http_status, headers_mapping[headers]


def error_response_server_message(error_message):
    return error_response(400, {'server_response': error_message})


def redirect_response(redirection_url, http_status=301):
    return redirection_url, http_status, {}
