from pyramid.view import view_config
import DnD_battler as DnD
import threading, os, time
from collections import defaultdict

@view_config(route_name='home', renderer='DnD_app:templates/home.mako')
def dnder(request):
    beastial = '<!--serverside values-->'
    for name in sorted([DnD.Creature.beastiary[beast]['name'] for beast in DnD.Creature.beastiary], key=str.lower):
        beastial += f'<option value="{name}">{name}</option>'
    return {'beasts': beastial}
