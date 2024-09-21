package pt.aubay.resilience_demo.controller;

import lombok.extern.log4j.Log4j2;
import org.springframework.web.bind.annotation.*;
import pt.aubay.resilience_demo.service.ResilienceExampleService;

import java.util.concurrent.CompletableFuture;

@Log4j2
@RestController
@RequestMapping("/api/v1/resilience")
public class ResilienceExampleController {

    private final ResilienceExampleService resilienceExampleService;

    public ResilienceExampleController(ResilienceExampleService resilienceExampleService) {
        this.resilienceExampleService = resilienceExampleService;
    }


    /**
     * This method is the entry point where resilience patterns are applied.
     * The Circuit Breaker, Rate Limiter, and Retry are managed by annotations.
     * If any of these patterns detect a failure or condition, the method will handle it accordingly.
     */
    @GetMapping
    public CompletableFuture<String> listingExampleMethod(@RequestParam(name = "delay") boolean delay) {
        log.info("Simulating list...");
        log.info("Delay {}", delay);
        return CompletableFuture.supplyAsync(() -> {
            // Simulate long-running task
            return resilienceExampleService.performOperationWithResilience(delay);
        });
    }

    @PostMapping
    public String writingExampleMethod() {
        log.info("Simulating post...");
        return resilienceExampleService.performOperationWithResilience();
    }

    @PutMapping
    public String updatingExampleMethod() {
        log.info("Simulating update...");
        return resilienceExampleService.performOperationWithResilience();
    }
}
