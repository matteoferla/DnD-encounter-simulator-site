#!/usr/bin/env python
import os

try:
    import DnD_Battler
    rounds = 100
    wwe=DnD_Battler.Encounter("netsharpshooter","druid","barbarian","mega_tank","polar", "polar","polar")
    line=str(wwe.go_to_war(rounds))
except Exception as e:
    line="Error: "+str(e)

print(line)

def application(environ, start_response):

    ctype = 'text/plain'
    if environ['PATH_INFO'] == '/health':
        response_body = "1"
    elif environ['PATH_INFO'] == '/env':
        response_body = ['%s: %s' % (key, value)
                    for key, value in sorted(environ.items())]
        response_body = '\n'.join(response_body)
    else:
        ctype = 'text/html'
        response_body = '''<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>D&D Battle simulator</title>
<style>

</style>
</head>
<body>
<div style="padding: 40px">'''+line+'''</div>
</body>
</html>'''
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
