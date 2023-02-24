package pl.edu.pg.benchmarking.route1.place;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;
import org.springframework.web.client.RestTemplate;
import pl.edu.pg.benchmarking.route1.place.PlaceDto.GetPlaceDtoResponse;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

@Repository
public class PlaceRepository {
    private final RestTemplate restTemplate;
    private final String BASE_URL;

    @Autowired
    public PlaceRepository(@Value("${place-service.url}") String baseUrl) {
        this.restTemplate = new RestTemplateBuilder().build();
        this.BASE_URL = baseUrl;
    }

    public List<GetPlaceDtoResponse> findPlacesCoordinates(Collection<Integer> ids) {
        String idsParam = ids.stream().map(Object::toString).collect(Collectors.joining(","));
        ResponseEntity<GetPlaceDtoResponse[]> response = restTemplate.getForEntity(BASE_URL + "places?ids={ids}", GetPlaceDtoResponse[].class, idsParam);
        return Arrays.stream(response.getBody()).toList();
    }
}
