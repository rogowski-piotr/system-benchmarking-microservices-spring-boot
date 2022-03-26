package pl.edu.pg.benchmarking.place.dto;

import pl.edu.pg.benchmarking.place.Place;

import java.util.function.Function;

public class GetPlaceResponse {

    private Integer id;
    private String city;
    private String latitude;
    private String longitude;

    private GetPlaceResponse(Integer id, String city, String latitude, String longitude) {
        this.id = id;
        this.city = city;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public Integer getId() { return id; }

    public String getCity() { return city; }

    public String getLatitude() { return latitude; }

    public String getLongitude() { return longitude; }

    public static Function<Place, GetPlaceResponse> entityToDtoMapper() {
        return place -> new GetPlaceResponse(
                place.getId(), place.getCity(), place.getLatitude(), place.getLongitude());
    }
}
