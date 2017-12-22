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
    values = [
        {
            'action': 'aclon',
            'command': '/home/pi/oprint/bin/python /home/pi/.octoprint/data/roboACL/roboacl.py enable',
            'confirm': 'You are about to launch the setup wizard to enable remote access security features. You will have to complete the wizard in order to continue using the web dashboard. The dashboard and your printer will automatically restart once the wizard is finished. This will disrupt any active prints.',
            'name': 'Enable remote access security feature'
        },
        {
            'action': 'acloff',
            'command': '/home/pi/oprint/bin/python /home/pi/.octoprint/data/roboACL/roboacl.py disable',
            'confirm': 'You are about to disable the remote access security features and DELETE all user accounts. This will make your printer remotely accessible to everyone within your local network. The dashboard and your printer will automatically restart. This will disrupt any active prints.',
            'name': 'Disable remote access security feature'
        },
        {
            'action': 'divider'
        },
        {
            'action': 'streamon',
            'command': '/home/pi/scripts/webcam start',
            'confirm': False,
            'name': 'Start video stream'
        },
        {
            'action': 'streamoff',
            'command': '/home/pi/scripts/webcam stop',
            'confirm': False,
            'name': 'Stop video stream'
        }
    ]

    if 'actions' in config['system']:
        config['system']['actions'] = values
        write_to_file(config, path)
    else:
        pass

if __name__ == '__main__':
    main()
