package pl.edu.pg.benchmarking.place.dto;

import pl.edu.pg.benchmarking.place.Place;

import java.util.function.Function;

public class GetPlaceResponse {

    private Integer id;
    private String city;
    private String coordinates;

    private GetPlaceResponse(Integer id, String city, String coordinates) {
        this.id = id;
        this.city = city;
        this.coordinates = coordinates;
    }

    public Integer getId() { return id; }

    public String getCity() { return city; }

    public String getCoordinates() { return coordinates; }

    public static Function<Place, GetPlaceResponse> entityToDtoMapper() {
        return place -> new GetPlaceResponse(
                place.getId(), place.getCity(), place.getCoordinates());
    }
}
