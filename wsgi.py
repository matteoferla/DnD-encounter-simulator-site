#!/usr/bin/env python
import os

def application(environ, start_response):

    if environ['REQUEST_METHOD'] == 'POST':              #If POST...
        #from cgi import parse_qs
        try:
            request_body_size = int(environ['CONTENT_LENGTH'])
            request_body = environ['wsgi.input'].read(request_body_size)
        except (TypeError, ValueError):
            request_body = "0"

        #parsed_body = parse_qs(request_body)
        #value = parsed_body.get('test_text', [''])[0] #Returns the first value

        try:
            import json
            response_body = ""
            if type(request_body) is str:
                response_body ="request is a string"
            l=json.loads(str(request_body)[1:])
            rounds = 100
            response_body +=str(l)
            wwe=Encounter(*l)
            response_body +=str(wwe.go_to_war(rounds))
        except Exception as e:
            response_body = "ERROR line 26: "+str(e)

        status = '200 OK'
        headers = [('Content-type', 'text/plain')]
        start_response(status, headers)
        return [response_body]
    else:


        ctype = 'text/plain'
        if environ['PATH_INFO'] == '/health':
            response_body = "1"
        elif environ['PATH_INFO'] == '/env':
            response_body = ['%s: %s' % (key, value)
                        for key, value in sorted(environ.items())]
            response_body = '\n'.join(response_body)
        else:
            ctype = 'text/html'
            h=open("app-root/repo/static.html")
            response_body = h.read()

        response_body = response_body.encode('utf-8')

        status = '200 OK'
        response_headers = [('Content-Type', ctype), ('Content-Length', str(len(response_body)))]
        #
        start_response(status, response_headers)
        return [response_body ]

#
# Below for testing only
#
if __name__ == '__main__':
    from wsgiref.simple_server import make_server
    httpd = make_server('localhost', 8051, application)
    # Wait for a single request, serve it and quit.
    httpd.handle_request()
