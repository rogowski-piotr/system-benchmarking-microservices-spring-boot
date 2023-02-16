import requests
import json


def test_place_service():
    # given
    host = "localhost"
    port = "8080"
    endpoint = "/api/places"
    params = "?ids=1,22,333,1000"
    url = f"http://{host}:{port}{endpoint}{params}"
    payload = {}
    headers = {}

    # when
    response = requests.request("GET", url, headers=headers, data=payload)

    # then
    assert response.status_code == 200, f"Unexpected response code {response.status_code}, expected 200"
    places_amount_in_response = len(json.loads(response.text))
    expected_places_amount = 4
    assert places_amount_in_response == expected_places_amount, \
        f"Expected {expected_places_amount} places, found {places_amount_in_response}"


def test_distance_service():
    # given
    host = "localhost"
    port = "8080"
    endpoint = "/api/distance"
    params = ""
    url = f"http://{host}:{port}{endpoint}{params}"
    payload = json.dumps([
        {
            "placeId1": 1,
            "placeId2": 2,
            "coordinates1": "54.367, 18.633",
            "coordinates2": "50.05, 19.95"
        },
        {
            "placeId1": 3,
            "placeId2": 4,
            "coordinates1": "55.367, 19.633",
            "coordinates2": "52.05, 14.95"
        },
        {
            "placeId1": 1,
            "placeId2": 3,
            "coordinates1": "54.367, 18.633",
            "coordinates2": "55.367, 19.633"
        }
    ])
    headers = {"Content-Type": "application/json"}

    # when
    response = requests.request("POST", url, headers=headers, data=payload)

    # then
    assert response.status_code == 200, \
        f"Unexpected response code {response.status_code}, expected 200"
    
    expected_distances_elements = 3
    expected_distance_value_at_first_element = 488

    json_response = json.loads(response.text)
    distances_amount_in_response = int(len(json_response))
    distance_value_at_first_element = int(json_response[0]["distance"])
    
    assert distances_amount_in_response == expected_distances_elements, \
        f"Bad distances amount in response list: ({str.strip(response.text)}), expected {expected_distances_elements}"
    assert distance_value_at_first_element == expected_distance_value_at_first_element, \
        f"Bad distances value in first element of response list: ({str.strip(response.text)}), expected {expected_distance_value_at_first_element}"


def test_route1_service():
    # given
    host = "localhost"
    port = "8080"
    endpoint = "/api/route1"
    params = "?id=13,46,235,456,3"
    url = f"http://{host}:{port}{endpoint}{params}"
    payload = {}
    headers = {}

    # when
    response = requests.request("GET", url, headers=headers, data=payload)

    # then
    expected_response = "[13,235,3,46,456]"
    assert response.status_code == 200, \
        f"Unexpected response code {response.status_code}, expected 200"
    assert str.strip(response.text) == expected_response, \
        f"Bad route ({str.strip(response.text)}), expected {expected_response}"


def test_route2_service():
    # given
    host = "localhost"
    port = "8080"
    endpoint = "/api/route2"
    params = "?id=5,900,2317,2"
    url = f"http://{host}:{port}{endpoint}{params}"
    payload = {}
    headers = {}

    # when
    response = requests.request("GET", url, headers=headers, data=payload)

    # then
    expected_response = "[5,2,2317,900,5]"
    assert response.status_code == 200, \
        f"Unexpected response code {response.status_code}, expected 200"
    assert str.strip(response.text) == expected_response, \
        f"Bad route ({str.strip(response.text)}), expected {expected_response}"
