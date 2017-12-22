#!/home/pi/oprint/bin/python
import sys
import subprocess
import yaml
import os

def get_config(path):
    f = open(path, 'r')
    config = yaml.load(f)
    f.close()
    return config

def write_to_file(config, path):
    f = open(path, 'w')
    yaml.dump(config, f, default_flow_style=False)
    f.close()

def enable_acl(config):
    if 'salt' not in config['accessControl']:
        config['accessControl']['enabled'] = True
        config['server']['firstRun'] = True
    return config

def disable_acl(config):
    config['accessControl'] = {'enabled': False}
    path = '/home/pi/.octoprint/users.yaml'
    if os.path.isfile(path):
        os.remove(path)
    return config


if __name__ == '__main__':
    choice = sys.argv[1]
    if choice == 'enable':
        enable = True
    elif choice == 'disable':
        enable = False
    else:
        raise("Incorrect argument! Expecting enable or disable. Instead got {}".format(choice ) )

    path = '/home/pi/.octoprint/config.yaml'
    if enable:
        write_to_file(
            enable_acl(
                get_config(path )
            ), path
        )
    else:
        write_to_file(
            disable_acl(
                get_config(path )
            ), path
        )

    sys.exit(0)
