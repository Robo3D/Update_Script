def detect_model(path):
    import yaml
    import os
    with open(path, 'r') as f:
        config = yaml.load(f)

    _model = config['plugins']['RoboLCD']['Model']

    if 'C2' in _model:
        if os.path.exists('/dev/fb1'):
            model = 'c2'
        else:
            model = 'c2hdmi'
    else:
        model = 'r2'
    return model
