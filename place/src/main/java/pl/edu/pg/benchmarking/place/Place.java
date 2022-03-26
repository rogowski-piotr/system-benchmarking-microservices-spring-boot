package pl.edu.pg.benchmarking.place;

import java.util.List;

public class Place {

    private Integer id;
    private String city;
    private String latitude;
    private String longitude;

    Place (Integer id, String city, String latitude, String longitude) {
        this.id = id;
        this.city = city;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    @Override
    public String toString() {
        return String.format("{ id: %d, cityName: %s, latitude: %s, longitude: %s }", this.id, this.city, this.latitude, this.longitude);
    }

    public Integer getId() {
        return id;
    }

    public String getCity() {
        return city;
    }

    public String getLatitude() {
        return latitude;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public static List<Place> list = List.of(
            new Place(0, "name1", "a", "b")
    );

}
