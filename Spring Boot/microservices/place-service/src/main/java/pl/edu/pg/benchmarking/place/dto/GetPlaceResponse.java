package pl.edu.pg.benchmarking.place.dto;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import pl.edu.pg.benchmarking.place.Place;

import java.util.function.Function;

@Getter
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public class GetPlaceResponse {

    private Integer id;

    private String city;

    private String coordinates;

    public static Function<Place, GetPlaceResponse> entityToDtoMapper() {
        return place -> new GetPlaceResponse(
                place.getId(), place.getCity(), place.getCoordinates());
    }
}