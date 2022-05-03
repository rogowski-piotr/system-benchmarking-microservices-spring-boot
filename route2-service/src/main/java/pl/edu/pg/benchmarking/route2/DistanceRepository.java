package pl.edu.pg.benchmarking.route2;

import lombok.Builder;
import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;
import org.springframework.web.client.RestTemplate;

@Repository
public class DistanceRepository {
    private final RestTemplate restTemplate;
    private final String BASE_URL;

    @Autowired
    public DistanceRepository(@Value("${distance-service.url}") String baseUrl) {
        this.restTemplate = new RestTemplateBuilder().build();
        this.BASE_URL = baseUrl;
    }

    @Builder
    @Getter
    private static class GetDistanceRequest {
        private String coordinate1;
        private String coordinate2;
    }

    private static class GetDistanceResponse {
        @Getter private String distance;
    }

    public Double findDistance(String coordinate1, String coordinate2) {
        GetDistanceRequest requestDto = GetDistanceRequest.builder()
                .coordinate1(coordinate1)
                .coordinate2(coordinate2)
                .build();
        ResponseEntity<GetDistanceResponse> dto = restTemplate.postForEntity(BASE_URL + "/distance", requestDto, GetDistanceResponse.class);
        return Double.valueOf(dto.getBody().getDistance());
    }

}