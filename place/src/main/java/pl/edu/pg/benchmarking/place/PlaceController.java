package pl.edu.pg.benchmarking.place;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pl.edu.pg.benchmarking.place.dto.GetPlaceResponse;
import pl.edu.pg.benchmarking.place.dto.GetPlacesResponse;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("api/places")
public class PlaceController {

    private final PlaceRepository placeRepository;

    @Autowired
    public PlaceController(PlaceRepository placeRepository) {
        this.placeRepository = placeRepository;
    }

    @GetMapping
    public ResponseEntity<Iterable<GetPlacesResponse.Place>> getAllPlaces() {
        List<Place> resultList = placeRepository.getPlaces();
        return ResponseEntity.ok(
                GetPlacesResponse.entityToDtoMapper().apply(resultList));
    }

    @GetMapping("{id}")
    public ResponseEntity<GetPlaceResponse> getSinglePlace(@PathVariable(name = "id") Integer id) {
        Optional<Place> placeOptional = placeRepository.findById(id);
        return placeOptional
                .map(place -> ResponseEntity.ok(GetPlaceResponse.entityToDtoMapper().apply(place)))
                .orElseGet(() -> ResponseEntity.noContent().build());
    }

}