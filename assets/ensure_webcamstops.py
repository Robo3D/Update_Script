import yaml

def get_config(path):
    f = open(path, 'r')
    config = yaml.load(f)
    f.close()
    return config

def write_to_file(config, path):
    f = open(path, 'w')
    yaml.dump(config, f, default_flow_style=False)
    f.close()

def main():
    path = '/home/pi/.octoprint/config.yaml'
    config = get_config(path)
    if 'serverRestartCommand' in config['server']['commands']:
        config['server']['commands']['serverRestartCommand'] = '/home/pi/scripts/webcam stop && sleep 1 && sudo service octoprint restart'
        write_to_file(config, path)
    else:
        pass

if __name__ == '__main__':
    main()
