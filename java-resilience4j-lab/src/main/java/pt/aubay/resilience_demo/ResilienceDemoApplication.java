package pt.aubay.resilience_demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

@EnableAspectJAutoProxy
@SpringBootApplication
public class ResilienceDemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(ResilienceDemoApplication.class, args);
	}

}
