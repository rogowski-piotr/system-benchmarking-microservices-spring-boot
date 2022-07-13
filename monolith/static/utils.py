from static.exceptions import ParseArguments


def attributes(obj) -> dict:
    obj_attributes = {}
    for name in obj.__dict__.keys():
        if name[:1] != '_' and name != 'image':
            value = getattr(obj, name)
            obj_attributes[name] = value
    return obj_attributes


def parse_str_to_list(id: str) -> list:
    try:
        return [int(i) for i in id.split(',')]
    except ValueError:
        raise ParseArguments
