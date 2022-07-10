import requests
import json
from static.config import distance_service_url
from static.utils import attributes
from static.exceptions import DistanceServiceNotWorking


class DistanceRepository:
    def __init__(self) -> None:
        self.base_url = distance_service_url
    
    class GetDistanceDtoRequest:
        def __init__(self, coordinates1: str, coordinates2: str) -> None:
            self.coordinate1 = coordinates1
            self.coordinate2 = coordinates2
        
        def as_dict(self) -> dict:
            return attributes(self)

    class GetDistanceDtoResponse:
        def __init__(self, distance: str) -> None:
            self.distance = distance

    def find_distance(self, coordinates1: str, coordinates2: str) -> float:
        request_dto = self.GetDistanceDtoRequest(coordinates1, coordinates2).as_dict()
        headers = {'Content-Type': 'application/json'}
        data = json.dumps(request_dto)
        try:
            response = requests.request("POST", f"{self.base_url}distance", data=data, headers=headers)
            response_to_json = json.loads(response.text)
            return self.GetDistanceDtoResponse(float(response_to_json["distance"])).distance
        except:
            raise DistanceServiceNotWorking
