import requests
import json
from collections import ChainMap
from typing import ChainMap, List
from static.config import distance_service_url
from static.utils import attributes
from static.exceptions import DistanceServiceNotWorking
from website.distance.distance_dto import GetDistanceDtoRequest


class DistanceRepository:
    def __init__(self) -> None:
        self.base_url = distance_service_url

    def find_distances(self, places_response: list) -> ChainMap:
        request_body = self.prepare_request_body(places_response)
        request_body_to_json = json.dumps(request_body)
        headers = {'Content-Type': 'application/json'}
        try:
            response = requests.request("POST", f"{self.base_url}distance", data=request_body_to_json, headers=headers)
            response_list = json.loads(response.text)
            response_mapped = map(lambda distance: {(distance["placeId1"], distance["placeId2"]): distance["distance"]}, response_list)
            return ChainMap(*response_mapped)           
        except:
            raise DistanceServiceNotWorking

    def prepare_request_body(self, places_response: list) -> List[GetDistanceDtoRequest]:
        request_body_list = list()
        for place1 in places_response:
            for place2 in places_response:
                single_distance_dto = GetDistanceDtoRequest(place1.id, place2.id, place1.coordinates, place2.coordinates)
                request_body_list.append(single_distance_dto)
        return [place.as_dict() for place in request_body_list]
