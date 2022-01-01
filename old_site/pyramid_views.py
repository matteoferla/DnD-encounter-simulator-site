from pyramid.view import view_config
from extras_site import DnD
import threading, os, time
from collections import defaultdict

import logging
log = logging.getLogger(__name__)

if 'OPENSHIFT_BUILD_NAME' in os.environ:
    place = "server"
    apppath = "/opt/app-root/src/extras_site/"
else:
    place = "localhost"
    apppath = "extras_site/"
print(place)


class TimeoutError(Exception):
    pass


def old_dnder(request):
    beastial = '<!--serverside values-->'
    for name in sorted([DnD.Creature.beastiary[beast]['name'] for beast in DnD.Creature.beastiary], key=str.lower):
        beastial += '<option value="' + name + '">' + name + '</option>'
    return {'beasts': beastial}

@view_config(route_name='dnd', renderer='../templates/DnD.mako')
def dnder(request):
    beastial = '<!--serverside values-->'
    for name in sorted([DnD.Creature.beastiary[beast]['name'] for beast in DnD.Creature.beastiary], key=str.lower):
        beastial += '<option value="' + name + '">' + name + '</option>'
    return {'beasts': beastial}



@view_config(route_name='ajax_lineup', renderer='json')
def ajacean_dndlist(request):
    try:
        wwe = DnD.Encounter(*request.json_body)
        sides=defaultdict(int)
        for combatant in wwe.combattants:
            sides[combatant.alignment]+=combatant.hp
        return {'sides': [{'values': list(sides.values()), 'labels': list(sides.keys()), 'type': 'pie'}],
                'combatants': [{'name':combatant.name, 'side': combatant.alignment} for combatant in wwe.combattants]}
    except Exception as e:
        return {'battles': "Error: " + str(e)}


@view_config(route_name='ajax_dnd', renderer='json')
def ajacean_dnder(request):
    try:
        wwe = DnD.Encounter(*request.json_body)
        w = threading.Thread(target=wwe.go_to_war, args=(5000,))
        w.start()
        timer=time.time()+10
        while timer > time.time():
            time.sleep(0.5)
            if not w.is_alive():
                break
        else:
            wwe.KILL = True
        response = wwe.battle(1, 1).summary()
        print('Battle done...')
        add_to_tales(wwe)
        return response
    except Exception as e:
        return {'battles': "Error: " + str(e)}

def line_prepender(filename, line):
    with open(filename, 'r+', encoding='utf-8') as f:
        content = f.read()
        f.seek(0, 0)
        f.write(line.rstrip('\r\n') + '\n' + content)

def add_to_tales(battle):
    line_prepender(apppath+"tales.txt",str(battle))

@view_config(route_name='dnd_review', renderer='string')
def dnd_reviewer(request):
    return open(apppath+"tales.txt", encoding='utf-8').read().replace("<br/>","\n")
