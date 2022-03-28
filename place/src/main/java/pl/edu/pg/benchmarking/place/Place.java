package pl.edu.pg.benchmarking.place;

public class Place {

    private Integer id;
    private String city;
    private String coordinates;

    Place (Integer id, String city, String coordinates) {
        this.id = id;
        this.city = city;
        this.coordinates = coordinates;
    }

    @Override
    public String toString() {
        return String.format("{ id: %d, cityName: %s, coordinates: %s }", this.id, this.city, this.coordinates);
    }

    public Integer getId() {
        return id;
    }

    public String getCity() {
        return city;
    }

    public String getCoordinates() {
        return coordinates;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setCoordinates(String coordinates) {
        this.coordinates = coordinates;
    }

}
