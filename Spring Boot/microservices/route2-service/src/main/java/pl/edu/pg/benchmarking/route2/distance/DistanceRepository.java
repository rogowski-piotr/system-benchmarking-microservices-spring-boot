package pl.edu.pg.benchmarking.route2.distance;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;
import org.springframework.web.client.RestTemplate;
import pl.edu.pg.benchmarking.route2.distance.DistanceDto.GetDistanceRequest;
import pl.edu.pg.benchmarking.route2.distance.DistanceDto.GetDistanceResponse;
import pl.edu.pg.benchmarking.route2.place.PlaceDto.GetPlaceDtoResponse;

import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Repository
public class DistanceRepository {
    private final RestTemplate restTemplate;
    private final String BASE_URL;

    @Autowired
    public DistanceRepository(@Value("${distance-service.url}") String baseUrl) {
        this.restTemplate = new RestTemplateBuilder().build();
        this.BASE_URL = baseUrl;
    }

    @AllArgsConstructor(access = AccessLevel.PUBLIC)
    public static class PlacesPair {
        private int place1;
        private int place2;
        @Override
        public int hashCode() {
            return 61 * place1 + 67 * place2;
        }
        @Override
        public boolean equals(Object obj) {
            return ((PlacesPair) obj).place1 == this.place1 && ((PlacesPair) obj).place2 == this.place2;
        }
    }

    public Map<PlacesPair, Double> findDistances(List<GetPlaceDtoResponse> placesResponse) {
        List<GetDistanceRequest> requestBody = prepareRequestBody(placesResponse);
        ResponseEntity<GetDistanceResponse[]> dto = restTemplate.postForEntity(BASE_URL + "/distance", requestBody, GetDistanceResponse[].class);
        return Arrays.stream(dto.getBody()).collect(
                Collectors.toMap(e -> new PlacesPair(e.getPlaceId1(), e.getPlaceId2()), GetDistanceResponse::getDistance));
    }

    private List<GetDistanceRequest> prepareRequestBody(List<GetPlaceDtoResponse> placesResponse) {
        List<GetDistanceRequest> requestBodyList = new LinkedList<>();
        placesResponse.forEach(place1 -> {
            placesResponse.forEach(place2 -> {
                requestBodyList.add(
                    new GetDistanceRequest(place1.getId(), place2.getId(), place1.getCoordinates(), place2.getCoordinates()));
            });
        });
        return requestBodyList;
    }
}
