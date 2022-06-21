package pl.edu.pg.benchmarking.monolith.place.dto;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Collection;
import java.util.function.Function;
import java.util.stream.Collectors;

public class GetPlacesResponse {

    @Getter
    @AllArgsConstructor(access = AccessLevel.PRIVATE)
    public static class Place {

        private Integer id;

        private String city;
    }

    public static Function<Collection<pl.edu.pg.benchmarking.monolith.place.Place>, Iterable<Place>> entityToDtoMapper() {
        return places -> places.stream()
                .map(place -> new Place(place.getId(), place.getCity()))
                .collect(Collectors.toList());
    }

}