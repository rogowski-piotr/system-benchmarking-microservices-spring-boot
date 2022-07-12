import requests
import json


def test_place_service():
    # given
    host = "localhost"
    port = "8080"
    endpoint = "/api/places"
    params = ""
    url = f"http://{host}:{port}{endpoint}{params}"
    payload = {}
    headers = {}

    # when
    response = requests.request("GET", url, headers=headers, data=payload)

    # then
    assert response.status_code == 200
    places_amount_in_response = len(json.loads(response.text))
    expected_places_amount = 2318
    assert places_amount_in_response == expected_places_amount


def test_distance_service():
    # given
    host = "localhost"
    port = "8080"
    endpoint = "/api/distance"
    params = ""
    url = f"http://{host}:{port}{endpoint}{params}"
    payload = json.dumps({
        "coordinate1": "54.367, 18.633",
        "coordinate2": "50.05, 19.95"
    })
    headers = {"Content-Type": "application/json"}

    # when
    response = requests.request("POST", url, headers=headers, data=payload)

    # then
    expected_value = 488
    distance_value_in_response = int(json.loads(response.text)["distance"])
    assert response.status_code == 200
    assert distance_value_in_response == expected_value


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
    assert response.status_code == 200
    assert str.strip(response.text) == expected_response


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
    assert response.status_code == 200
    assert str.strip(response.text) == expected_response
