package pl.edu.pg.benchmarking.place;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor(access = AccessLevel.PUBLIC)
public class Place {

    private Integer id;

    private String city;

    private String coordinates;

}