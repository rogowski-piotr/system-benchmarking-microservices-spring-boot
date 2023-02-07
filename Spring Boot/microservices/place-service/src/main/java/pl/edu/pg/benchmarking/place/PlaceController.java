package pl.edu.pg.benchmarking.place;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import pl.edu.pg.benchmarking.place.dto.GetPlaceResponse;
import pl.edu.pg.benchmarking.place.dto.GetPlacesAllResponse;
import pl.edu.pg.benchmarking.place.dto.GetPlacesResponse;

import java.util.List;
import java.util.Optional;
import java.util.Set;

@RestController
@RequestMapping("api/places")
public class PlaceController {

    private final PlaceRepository placeRepository;

    @Autowired
    public PlaceController(PlaceRepository placeRepository) {
        this.placeRepository = placeRepository;
    }

    @GetMapping("/all")
    public ResponseEntity<Iterable<GetPlacesAllResponse.Place>> getAllPlaces() {
        List<Place> resultList = placeRepository.findAll();
        return ResponseEntity.ok(
                GetPlacesAllResponse.entityToDtoMapper().apply(resultList));
    }

    @GetMapping("{id}")
    public ResponseEntity<GetPlaceResponse> getSinglePlace(@PathVariable(name = "id") Integer id) {
        Optional<Place> placeOptional = placeRepository.findById(id);
        return placeOptional
                .map(place -> ResponseEntity.ok(GetPlaceResponse.entityToDtoMapper().apply(place)))
                .orElseGet(() -> ResponseEntity.noContent().build());
    }

    @GetMapping
    public ResponseEntity<Iterable<GetPlacesResponse.Place>> getPlaces(@RequestParam Set<Integer> ids) {
        List<Place> resultList = placeRepository.findByIds(ids);
        return ResponseEntity.ok(
                GetPlacesResponse.entityToDtoMapper().apply(resultList));
    }

}