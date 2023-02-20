import requests
import json
from typing import List
from static.config import place_service_url
from static.exceptions import PlaceNotFound, PlaceServiceNotWorking
from website.place.place_dto import GetPlaceDtoResponse


class PlaceRepository:
    def __init__(self) -> None:
        self.base_url = place_service_url

    def find_places_coordinates(self, ids: str) -> List[GetPlaceDtoResponse]:
        try:
            response = requests.request("GET", f"{self.base_url}places?ids={ids}")
            if response.status_code == 200:
                parsed_response_list = json.loads(response.text)
                mapped_result = map(lambda single_place_dict: GetPlaceDtoResponse(single_place_dict), parsed_response_list)
                return list(mapped_result)
            elif response.status_code == 404:
                raise PlaceNotFound(message=f"Places not found")
            elif response.status_code == 500:
                raise PlaceServiceNotWorking
        except requests.exceptions.ConnectionError:
            raise PlaceServiceNotWorking


        
        
