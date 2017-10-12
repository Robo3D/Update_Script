#! /home/pi/oprint/bin/python

import requests
from sys import exit
import yaml

url = 'http://127.0.0.1:8888'
state_url = url + '/state'
update_url = url + '/update'
config_path = '/home/pi/.octoprint/config.yaml'

def get_model(config_path):
    with open(config_path, 'r') as f:
        config = yaml.load(f)
    model = config['plugins']['RoboLCD']['Model']
    return model

def get_pkg(model, pkgs):
    pkg = [p for p in pkgs if model in p['version'] ]
    return pkg.pop()

if __name__ == '__main__':
    try:
        r = requests.get(state_url, timeout=1)
        if r.status_code is not 200:
            raise
        pkgs = r.json()
        # TODO distinguish between R2 and C2 packages and target
        if 'C2' in get_model(config_path):
            pkg = get_pkg('c2', pkgs)
        else:
            pkg = get_pkg('r2', pkgs)

        r = requests.post(update_url, json=pkg, timeout=1)
        if r.status_code is not 200:
            raise
    except Exception as e:
        print "####ERROR WITH RUNNNING PLAYBOOK!!!!"
        print e
        exit(1)
    else:
        exit(0)
