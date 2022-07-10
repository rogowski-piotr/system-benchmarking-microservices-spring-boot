import requests
import json
from static.config import place_service_url
from static.exceptions import PlaceNotFound, PlaceServiceNotWorking


class PlaceRepository:
    def __init__(self) -> None:
        self.base_url = place_service_url
    
    class GetPlaceDtoResponse:
        def __init__(self, place_id: int, city: str, coordinates: str) -> None:
            self.id = place_id
            self.city = city
            self.coordinates = coordinates

    def find_place_coordinates(self, place_id: int) -> str:
        try:
            response = requests.request("GET", f"{self.base_url}places/{place_id}")
            if response.status_code == 200:
                response_to_json = json.loads(response.text)
                return self.GetPlaceDtoResponse(int(response_to_json["id"]),
                    response_to_json["city"], response_to_json["coordinates"]).coordinates
            elif response.status_code == 404:
                raise PlaceNotFound(message=f"Place of given id ({place_id}) not found")
            elif response.status_code == 500:
                raise PlaceServiceNotWorking
        except requests.exceptions.ConnectionError:
            raise PlaceServiceNotWorking
