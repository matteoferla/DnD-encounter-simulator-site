#!/usr/bin/env python
import sys
import json
from old_dnd import DnD
import threading, time


class TimeoutError(Exception):
    pass

if __name__ == '__main__':
    place="local"
    host=8080
    apppath=""
else:
    place="server"
    host=8051
    apppath="app-root/repo/"
print(place)
DnD.Creature.beastiary= DnD.Creature.load_beastiary(apppath + 'beastiary.csv')

def application(environ, start_response):
    sys.stdout =environ['wsgi.errors']
    if environ['REQUEST_METHOD'] == 'POST':
        return poster(environ, start_response)
    else:  #get
        return getter(environ, start_response)

def sendindex():
    ctype = 'text/html'
    h=open(apppath+"static.html")
    response_body = h.read()
    x='<!--serverside values-->'
    for name in sorted([DnD.Creature.beastiary[beast]['name'] for beast in DnD.Creature.beastiary], key=str.lower):
        x+='<option value="'+name+'">'+name+'</option>'
    response_body=response_body.replace("<!--LABEL-->",x)
    response_body = response_body.encode('utf-8')
    return ctype, response_body

def line_prepender(filename, line):
    with open(filename, 'r+', encoding='utf-8') as f:
        content = f.read()
        f.seek(0, 0)
        f.write(line.rstrip('\r\n') + '\n' + content)

def sendreviewpage():
    return open(apppath+"tales.txt", encoding='utf-8').read().replace("<br/>","\n").encode('utf-8')

def add_to_tales(battle):
    line_prepender(apppath+"tales.txt",str(battle))

def getter(environ, start_response):
    ctype = 'text/plain'
    if not environ['PATH_INFO']:  #this never happens.! I thought it did, but it was an ecoding error
        ctype,response_body=sendindex()
    elif environ['PATH_INFO'] == '/health':
        response_body = "1"
    elif environ['PATH_INFO'] == '/review':
        response_body = sendreviewpage()
    elif environ['PATH_INFO'] == '/favicon.ico':
        ctype='image/x-icon'
        response_body = open('wsgi/static/favicon.ico', 'rb').read()
    elif environ['PATH_INFO'].find('/static') != -1: #why is localhost wsgi/static not working?!! It i quicker to botch it for now.
        #ctype = environ['HTTP_ACCEPT'].split(',')[0]
        #print("path.... ", environ['PATH_INFO'])
        protoctype=environ['PATH_INFO'].split('.')[-1]
        if protoctype =='css':
            ctype='text/css'
            response_body = open('wsgi'+environ['PATH_INFO'],encoding='utf-8').read().encode('utf-8')
        elif protoctype =='js':
            ctype='text/javascript'
            response_body = open('wsgi'+environ['PATH_INFO'],encoding='utf-8').read().encode('utf-8')
        elif protoctype =='ico':
            ctype='image/x-icon'
            response_body = open('wsgi'+environ['PATH_INFO'],'rb').read()
        elif protoctype =='woff2' or protoctype =='woff':
            ctype='application/x-font-woff'
            response_body = open('wsgi'+environ['PATH_INFO'],'rb').read()
        elif protoctype =='ttf':
            ctype='application/x-font-TrueType'
            response_body = open('wsgi'+environ['PATH_INFO'],'rb').read()
        else:
            ctype='text/plain'
            response_body = open('wsgi'+environ['PATH_INFO'],'rb').read()
    elif environ['PATH_INFO'] == '/env':
        response_body =""
        '''
        response_body = ['%s: %s' % (key, value) for key, value in sorted(environ.items())]
        response_body = '\n'.join(response_body)
        '''
    else:
        ctype,response_body=sendindex()
    status = '200 OK'
    response_headers = [('Content-Type', ctype), ('Content-Length', str(len(response_body)))]
    start_response(status, response_headers)
    return [response_body]

def poster(environ, start_response):              #If POST...
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
        l = json.loads(str(request_body)[2:-1])
        wwe = DnD.Encounter(*l)
        w=threading.Thread(target=wwe.go_to_war,args=(1000,))
        w.start()
        time.sleep(10)
        wwe.KILL = True
        response_body = wwe.battle(1, 1).json()
        add_to_tales(wwe)
    except Exception as e:
        print(e)
        response_body = json.dumps({'battles':"Error: "+str(e)})
    ctype = 'text/plain'
    response_body = response_body.replace("\n","<br/>")
    response_body = response_body.encode('utf-8')
    status = '200 OK'
    response_headers = [('Content-Type', ctype), ('Content-Length', str(len(response_body)))]
    start_response(status, response_headers)
    return [response_body]

if __name__ == '__main__':
    from wsgiref.simple_server import make_server
    httpd = make_server('localhost', host, application)
    httpd.serve_forever()