import yaml

def get_data(filename):
    with open(filename, "r") as yaml_file:
        data = yaml.safe_load(yaml_file)
    return data

data = get_data("problems.yaml")

