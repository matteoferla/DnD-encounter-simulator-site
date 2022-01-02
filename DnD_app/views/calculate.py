from pyramid.view import view_config, view_defaults
from pyramid.request import Request
import DnD_battler as DnD
import time
from functools import wraps
from threading import Thread
from typing import *
from collections import defaultdict
import logging
from io import StringIO

DnD.log.setLevel(logging.INFO)

class TimeoutError(Exception):
    pass


def safecall(method: Callable) -> dict:
    @wraps(method)
    def wrapper(self, *args, **kwargs):
        try:
            return method(self, *args, **kwargs)
        except Exception as err:
            raise err
            return {'battles': f'{err.__class__.__name__}: {err}'}
    return wrapper


class BattleViews:
    """
    Routes: simulate, review and lineup
    """

    def __init__(self, request: Request):
        self.request = request

    tales = []  # formerly a file for permanence. NB class attribute gets modified!

    @view_config(route_name='simulate', renderer='json')
    @safecall
    def simulate(self) -> dict:
        timeout = 10
        print(self.request.text)
        encounter = DnD.Encounter(*self.request.json_body)
        thread = Thread(target=encounter.go_to_war, args=(5000,))
        thread.start()
        timer = time.time() + timeout
        while timer > time.time():
            time.sleep(0.5)
            if not thread.is_alive():
                break
        else:
            encounter.KILL = True
        # get a single narrated battle
        stream = StringIO()
        handler = logging.StreamHandler(stream)
        handler.setLevel(logging.DEBUG)
        encounter.log.addHandler(handler)
        encounter.log.setLevel(logging.DEBUG)
        encounter.battle(reset=True)
        stream.seek(0)
        encounter.masterlog=stream.read()
        encounter.log.removeHandler(handler)
        encounter.log.setLevel(logging.INFO)
        response = encounter.json()
        self.__class__.tales.append(str(encounter).replace("\n", "<br/>"))
        return response

    @view_config(route_name='review', renderer='string')
    def review(self):
        return '\n\n'.join(self.tales[-100:])

    @view_config(route_name='lineup', renderer='json')
    @safecall
    def lineup(self):
        try:
            wwe = DnD.Encounter(*self.request.json_body)
            sides = defaultdict(int)
            for combatant in wwe.combattants:
                sides[combatant.alignment] += combatant.hp
            return {'sides':      [{'values': list(sides.values()), 'labels': list(sides.keys()), 'type': 'pie'}],
                    'combatants': [{'name': combatant.name, 'side': combatant.alignment} for combatant in
                                   wwe.combattants]}
        except Exception as e:
            return {'battles': "Error: " + str(e)}
