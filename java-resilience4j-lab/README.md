# TechTalk Hands-On Lab: Implementing Resilience Patterns with Resilience4j

Welcome to the TechTalk hands-on lab! In this session,
we’ll be enhancing an existing Java application with resilience patterns using the Resilience4j library.
Resilience4j is a lightweight fault tolerance library.
We will cover the implementation of various resilience patterns including Circuit Breaker, Rate Limiter, Timelimiter,
and Retry.

## Prerequisites

- Java Development Kit (JDK) 17 or higher
- Maven (for dependency management)
- An IDE (e.g., IntelliJ IDEA, Eclipse, VSCode)
- The Java application code (provided)

## Objectives

1. **Integrate Resilience4j** into the existing Spring application.
2. **Implement Circuit Breaker** to handle fault tolerance.
3. **Add Rate Limiting** to control the rate of requests.
4. **Set Up Retry Mechanisms** to handle transient failures.
5. **Set Up TimeLimiter Mechanisms** to handle timeout failures.

## Setup

1. **Clone the Repository**

   ```bash
   git clone git@github.com:Pedro-Appel/aubay-tech-talks.git
   cd java-resilience4j-lab
   ```

2. **Import the Project**

   Open the project in your preferred IDE.

3. **Add Dependencies**

   Add the following dependencies to your `pom.xml`:

   ```xml
     <dependency>
         <groupId>io.github.resilience4j</groupId>
         <artifactId>resilience4j-spring-boot3</artifactId>
         <version>2.2.0</version>
     </dependency>
   ```
## Circuit Breaker

1. **Annotate the desired class with the @CircuitBreaker annotation**

   On your Controller:

   ```java
   import io.github.resilience4j.circuitbreaker.annotation.CircuitBreaker;
   
   @RestController
   @RequestMapping("/api/v1/resilience")
   public class Controller {

       @CircuitBreaker(name = "backend")
       public static Object resilientEndpoint() {
            service.foo();
       }
   }
   ```

2. **Configure your circuit break**

   ```YML
   resilience4j.circuitbreaker:
     instances:
      backend:
         registerHealthIndicator: true
         slidingWindowSize: 10  
         permittedNumberOfCallsInHalfOpenState: 10
         automaticTransitionFromOpenToHalfOpenEnabled: true
         slidingWindowType: COUNT_BASED
         minimumNumberOfCalls: 5
         waitDurationInOpenState: 3s
         failureRateThreshold: 50
         eventConsumerBufferSize: 10
   ```

## Rate Limiter

1. **Annotate the desired class with the @RateLimiter annotation**

   On your Controller:

   ```java
      import io.github.resilience4j.ratelimiter.annotation.RateLimiter;
      
      @RestController
      @RequestMapping("/api/v1/resilience")
      public class Controller {

        @RateLimiter(name = "backend")
        public static Object resilientEndpoint() {
            service.foo();
        }
    }
   ```

2. **Configure your RateLimiter**



   ```YML
   resilience4j.ratelimiter:
      instances:
         backend:
            limitForPeriod: 20
            limitRefreshPeriod: 1s
            timeoutDuration: 0s
            registerHealthIndicator: true
            subscribe-for-events: true

   ```

## Retry

1. **Annotate the desired class with the @Retry annotation**

   On your Controller:

   ```java
   import io.github.resilience4j.retry.annotation.Retry;
   
   @RestController
   @RequestMapping("/api/v1/resilience")
   public class Controller {

       @Retry(name = "backend")
       public static Object resilientEndpoint() {
            service.foo();
       }
   }
   ```

2. **Configure your retry**

   ```YML
   resilience4j.retry:
      instances:
         backend:
            maxAttempts: 1
            waitDuration: 500ms
            enableExponentialBackoff: true
            exponentialBackoffMultiplier: 2
            retryExceptions:
              - org.springframework.web.client.HttpServerErrorException
   ```
## TimeLimiter

1. **Annotate the desired class with the @TimeLimiter annotation**

   On your Controller:

   ```java
   import io.github.resilience4j.timelimiter.annotation.TimeLimiter;
   
   @RestController
   @RequestMapping("/api/v1/resilience")
   public class Controller {

       @TimeLimiter(name = "backend")
       public static Object resilientEndpoint() {
            service.foo();
       }
   }
   ```

2. **Configure your time limiter**

   ```YML
   resilience4j.timelimiter:
    instances:
      backend:
        timeoutDuration: 5s
        cancelRunningFuture: true
   ```


## Adjust error handling for better traces

1. **Create a class and annotate it with @ControllerAdvice**

   ```java
      import lombok.extern.log4j.Log4j2;
      import org.springframework.web.bind.annotation.ControllerAdvice;
      
      import java.util.concurrent.TimeoutException;
      
      @Log4j2
      @ControllerAdvice
      public class CustomExceptionHandler {

      }
   ```

2. **Create methods to handle each Resilience exception**

   ```java
   import io.github.resilience4j.circuitbreaker.CallNotPermittedException;
   import io.github.resilience4j.ratelimiter.RequestNotPermitted;
   import lombok.extern.log4j.Log4j2;
   import org.springframework.http.HttpStatus;
   import org.springframework.web.bind.annotation.ControllerAdvice;
   import org.springframework.web.bind.annotation.ExceptionHandler;
   import org.springframework.web.bind.annotation.ResponseStatus;
   
   import java.util.concurrent.TimeoutException;
   
   @Log4j2
   @ControllerAdvice
   public class CustomExceptionHandler {
   
   
       @ExceptionHandler({ RequestNotPermitted.class })
       @ResponseStatus(HttpStatus.TOO_MANY_REQUESTS)
       public void handleRateLimiterException(RequestNotPermitted ex) {
       }
   
       @ExceptionHandler(CallNotPermittedException.class)
       @ResponseStatus(HttpStatus.SERVICE_UNAVAILABLE)
       public void handleCircuitBreakerException(CallNotPermittedException ex) {
       }
   
       @ExceptionHandler(TimeoutException.class)
       @ResponseStatus(HttpStatus.GATEWAY_TIMEOUT) // 504 status code
       public void handleTimeoutException(TimeoutException ex) {
       }
   
       @ExceptionHandler(Exception.class)
       @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
       public void handleGenericException(Exception ex) {}
   }
   ```

## Run the Application

1. **Build the Application**

   If you’re using Maven, run:

   ```bash
   mvn clean install
   ```

2. **Run the Application**

   Run the application from your IDE or using the command line.

   ```bash
   mvn spring-boot:run
   ```


## Conclusion

Congratulations on completing the hands-on lab! You have successfully integrated Circuit Breaker, Rate Limiter, Retry, Time Limiter patterns into your Java application using Resilience4j. These patterns will help in improving the robustness and reliability of your application.

Feel free to experiment with the configurations and try different scenarios to see how each resilience pattern behaves under various conditions.

For more details and advanced configurations, refer to the [Resilience4j documentation](https://resilience4j.readme.io/).
