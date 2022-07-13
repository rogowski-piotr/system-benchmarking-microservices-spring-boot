class ParseArguments(Exception):
    pass


class PlaceNotFound(Exception):
    def __init__(self, message):
        self.message = message


class PlaceServiceNotWorking(Exception):
    pass


class DistanceServiceNotWorking(Exception):
    pass
