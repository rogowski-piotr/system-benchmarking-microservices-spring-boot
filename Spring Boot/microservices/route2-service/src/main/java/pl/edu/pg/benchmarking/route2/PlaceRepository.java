package pl.edu.pg.benchmarking.route2;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;
import org.springframework.web.client.RestTemplate;

@Repository
public class PlaceRepository {
    private final RestTemplate restTemplate;
    private final String BASE_URL;

    @Autowired
    public PlaceRepository(@Value("${place-service.url}") String baseUrl) {
        this.restTemplate = new RestTemplateBuilder().build();
        this.BASE_URL = baseUrl;
    }

    private static class GetPlaceDtoResponse {
        Integer id;
        String city;
        @Getter String coordinates;
    }

    public String findPlaceCoordinates(int id) {
        ResponseEntity<GetPlaceDtoResponse> dto = restTemplate.getForEntity(BASE_URL + "places/" + id, GetPlaceDtoResponse.class);
        return dto.getBody().getCoordinates();
    }

}