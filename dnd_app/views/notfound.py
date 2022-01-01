from pyramid.view import notfound_view_config
from pyramid.exceptions import URLDecodeError
from pyramid.view import exception_view_config
from pyramid.traversal import DefaultRootFactory
import time

from pyramid.request import Request

@notfound_view_config(renderer='json')
def notfound_view(request):
    request.response.status = 404
    time.sleep(1)
    return {'status': 404}

@exception_view_config(context=URLDecodeError, renderer='json')
def attack_view(context: DefaultRootFactory, request: Request):
    """This is caused by an attempted null byte url attack"""
    request.response.status = 418
    request.environ['PATH_INFO'] = 'HACKING-ATTEMPT'
    time.sleep(1)
    return {'status': 418}
