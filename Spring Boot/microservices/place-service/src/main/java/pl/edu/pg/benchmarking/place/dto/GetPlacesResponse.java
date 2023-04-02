package pl.edu.pg.benchmarking.place.dto;

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
        private String coordinates;
    }

    public static Function<Collection<pl.edu.pg.benchmarking.place.Place>, Iterable<Place>> entityToDtoMapper() {
        return places -> places.stream()
                    .map(place -> new Place(place.getId(), place.getCoordinates()))
                    .collect(Collectors.toList());
    }

}