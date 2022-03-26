package pl.edu.pg.benchmarking.place.dto;

import java.util.Collection;
import java.util.function.Function;
import java.util.stream.Collectors;

public class GetPlacesResponse {

    public static class Place {
        private Integer id;
        private String city;

        private Place(Integer id, String city) {
            this.id = id;
            this.city = city;
        }

        public Integer getId() { return id; }

        public String getCity() { return city; }
    }

    public static Function<Collection<pl.edu.pg.benchmarking.place.Place>, Iterable<Place>> entityToDtoMapper() {
        return places -> places.stream()
                    .map(place -> new Place(place.getId(), place.getCity()))
                    .collect(Collectors.toList());
    }

}
