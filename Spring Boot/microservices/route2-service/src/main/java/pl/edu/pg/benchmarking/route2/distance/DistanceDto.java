package pl.edu.pg.benchmarking.route2.distance;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;

public class DistanceDto {

    @AllArgsConstructor(access = AccessLevel.PUBLIC)
    @Getter
    public static class GetDistanceRequest {
        private int placeId1;
        private int placeId2;
        private String coordinates1;
        private String coordinates2;
    }

    @Getter
    public static class GetDistanceResponse {
        private int placeId1;
        private int placeId2;
        private Double distance;
    }

}
