package pl.edu.pg.benchmarking.monolith.algorithm1;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;
import org.springframework.web.client.RestTemplate;
import org.springframework.beans.factory.annotation.Value;

@Repository
public class PlaceRepositoryExternal {
    private final RestTemplate restTemplate;
    private final String BASE_URL;

    @Autowired
    public PlaceRepositoryExternal(@Value("${place-service.url}") String baseUrl) {
        this.restTemplate = new RestTemplateBuilder().build();
        this.BASE_URL = baseUrl;
    }

    private static class GetPlaceDtoResponse {
        Integer id;
        String city;
        @Getter
        String coordinates;
    }

    public String findPlaceCoordinates(int id) {
        ResponseEntity<GetPlaceDtoResponse> dto = restTemplate.getForEntity(BASE_URL + "places/" + id, GetPlaceDtoResponse.class);
        return dto.getBody().getCoordinates();
    }

}