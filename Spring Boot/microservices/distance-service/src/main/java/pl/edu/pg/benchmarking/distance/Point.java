package pl.edu.pg.benchmarking.distance;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor(access = AccessLevel.PUBLIC)
public class Point {
    private int placeId1;
    private int placeId2;
    private Double latitude1;
    private Double longitude1;
    private Double latitude2;
    private Double longitude2;
}
