from enum import IntEnum


def attributes(obj) -> dict:
    pr = {}
    for name in obj.__dict__.keys():
        if name[:1] != '_' and name != 'image':
            value = getattr(obj, name)
            pr[name] = value
    return pr 
