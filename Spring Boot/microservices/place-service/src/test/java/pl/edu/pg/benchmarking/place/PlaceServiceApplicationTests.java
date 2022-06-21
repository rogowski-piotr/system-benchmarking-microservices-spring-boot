package pl.edu.pg.benchmarking.place;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)
class PlaceServiceApplicationTests {

	@Autowired
	private TestRestTemplate template;

	@Test
	public void checkGetPlacesReturnStatus200() {
		ResponseEntity<String> result = template.getForEntity("/api/places", String.class);
		assertEquals(HttpStatus.OK, result.getStatusCode());
	}

	@Test
	public void checkGetPlaceReturnStatus200() {
		ResponseEntity<String> result = template.getForEntity("/api/places/1", String.class);
		assertEquals(HttpStatus.OK, result.getStatusCode());
	}

}
