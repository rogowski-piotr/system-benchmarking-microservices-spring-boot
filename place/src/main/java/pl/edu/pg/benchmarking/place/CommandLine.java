package pl.edu.pg.benchmarking.place;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.logging.Logger;

@Component
public class CommandLine implements CommandLineRunner {

    private final Logger LOG = Logger.getLogger(this.getClass().getName());

    @Override
    public void run(String... args) {
        LOG.info("Starting");
    }
}
