package pt.aubay.resilience_demo.service;


import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpServerErrorException;

import java.util.Random;
import java.util.concurrent.TimeUnit;

@Log4j2
@Service
public class ResilienceExampleService {

    public String performOperationWithResilience(boolean delay) {
        log.info("Starting the operation with resilience patterns...");

        String result = unreliableExternalService(delay);

        log.info("Operation successful, received response: {}", result);
        return result;
    }


    public String performOperationWithResilience() {
        return performOperationWithResilience(false);
    }

    /**
     * Simulates an external service call that is unreliable and might fail.
     * This method is where the actual business logic would be implemented.
     *
     * @return A response from the external service.
     * @throws RuntimeException if the external service fails.
     */
    private String unreliableExternalService(boolean delay) {
        log.info("Calling the unreliable external service...");

        if (delay) {
            int delaySeconds = new Random().nextInt(5, 10);
            log.info("Simulating delay...");
            log.info("Delay seconds: {}", delaySeconds);
            try {
                TimeUnit.SECONDS.sleep(delaySeconds);
                if (delaySeconds > 8)
                    throw new RuntimeException("External service call took too long");
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                log.error("Thread was interrupted during sleep", e);
            }
        }

        // Simulate random failures
        int random = (int) (Math.random() * 100);
        log.info("Chance to succeed: {}%", random);
        if (random < 35) {
            log.warn("External service failed, throwing exception...");
            throw new HttpServerErrorException(HttpStatus.INTERNAL_SERVER_ERROR, "Simulated external service failure");
        }

        log.info("External service succeeded.");
        return "Service Response";
    }
}
