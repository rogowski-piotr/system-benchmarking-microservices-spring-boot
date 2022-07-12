from static.exceptions import ParseArguments


def attributes(obj) -> dict:
    pr = {}
    for name in obj.__dict__.keys():
        if name[:1] != '_' and name != 'image':
            value = getattr(obj, name)
            pr[name] = value
    return pr


def parse_str_to_list(id: str) -> list:
    try:
        return [int(i) for i in id.split(',')]
    except ValueError:
        raise ParseArguments
