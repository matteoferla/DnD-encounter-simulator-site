#!/usr/bin/env python
import os
import sys
place="server"
host=8051
apppath="app-root/repo/"
if place == "local":
    host=8080
    apppath=""
    #The folder static is present both under the root and wsgi/

def application(environ, start_response):
    sys.stdout =environ['wsgi.errors']
    print("Request recieved")

    if environ['REQUEST_METHOD'] == 'POST':              #If POST...
        #from cgi import parse_qs
        try:
            request_body_size = int(environ['CONTENT_LENGTH'])
            request_body = environ['wsgi.input'].read(request_body_size)
        except (TypeError, ValueError):
            request_body = "0"
            print("No request found")

        #parsed_body = parse_qs(request_body)
        #value = parsed_body.get('test_text', [''])[0] #Returns the first value

        try:
            import json, DnD_Battler

            l=json.loads(str(request_body)[2:-1])
            rounds = 100
            print("Request:")
            print(request_body)
            print("parsed as:")
            print(l)
            wwe=DnD_Battler.Encounter(*l)
            print("Encounter ready:")
            response_body =wwe.go_to_war(rounds).json()
            print("Simulation complete")
            print(response_body)
        except Exception as e:
            print(e)
            response_body = "\nERROR: "+str(e)
        ctype = 'text/plain'
        response_body = response_body.replace("\n","<br/>")
        response_body = response_body.encode('utf-8')
        status = '200 OK'
        response_headers = [('Content-Type', ctype), ('Content-Length', str(len(response_body)))]
        start_response(status, response_headers)
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
            h=open(apppath+"static.html")
            response_body = h.read()

        response_body = response_body.encode('utf-8')
        status = '200 OK'
        response_headers = [('Content-Type', ctype), ('Content-Length', str(len(response_body)))]
        start_response(status, response_headers)
        return [response_body]

#
# Below for testing only
#
if __name__ == '__main__':

    from wsgiref.simple_server import make_server
    httpd = make_server('localhost', host, application)
    # Wait for a single request, serve it and quit.
    httpd.serve_forever()
