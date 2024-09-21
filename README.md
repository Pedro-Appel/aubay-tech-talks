# TechTalk Hands-On Lab: Resilience and Observability

Welcome to the TechTalk hands-on lab! This lab is designed to guide you through three crucial aspects of modern software development: Resilience, CI/CD workflows, and Observability. By the end of this lab, you’ll have hands-on experience with Resilience4j in Java, setting up a GitHub workflow, and implementing observability with Prometheus.

## Overview

This lab is divided into three sections:

1. **Java Resilience4j**
2. **GitHub Workflow**
3. **Prometheus Observability**

You should complete these sections in the order presented. Each section builds on the concepts learned in the previous one, providing a comprehensive understanding of resilience and observability in software development.

## 1. Java Resilience4j

In this section, you’ll work with an existing Java application that demonstrates how to implement resilience patterns using the Resilience4j library. Resilience patterns like Circuit Breaker, Rate Limiter, and Retry are essential for building robust applications that can handle failures gracefully.

### **Key Objectives:**

- Integrate Resilience4j into the Java application.
- Implement Circuit Breaker, Rate Limiter, Time limiter, and Retry patterns.
- Test the resilience features and understand their impact on application stability.

1. CD to directory java-resilience4j-lab
2. Complete the readme inside that dir
3. Push the changes to your master branch

## 2. GitHub Workflow

The second part of this lab focuses on Continuous Integration/Continuous Deployment (CI/CD) using GitHub Actions.
Here, you will learn key concepts like the build, test, and deployment processes of your Java application.
And implement the trigger for the action and also configure your repository to publish to your docker-hub


**Pre-requirements**
1. [Create a docker-hub account](https://docs.docker.com/accounts/create-account/)

### **Key Objectives:**
- Understand a GitHub Actions workflow.
- Integrate the Java App with a CI/CD pipeline and then publish the image to dockerhub

### Step-by-Step
1. Go to the workflow directory (root/.github/workflows)
2. Edit the ci-cd.yml with the trigger described bellow
3. On you github repository go to " Settings > Secrets and Variables > Actions "
4. Add 2 new secrets on the "Repository secrets" DOCKERHUB_TOKEN & DOCKERHUB_USERNAME
    5. You can get this 2 secrets from you docker hub "Personal Access Tokens" [page](https://app.docker.com/settings/personal-access-tokens)
6. Push the updated ci-cd.yml and what it run in the Actions page of you repository
7. After the workflow is completed you can test modifying the docker-compose in the root of the project with the path of the created image
    8. In the docker-compose.yml **line 8** where it says **"<<DOCKER_USER>>/lab-java4j:<<IMAGE_TAG>>"** replace with your newly created repository
        9. You can find it going to the https://hub.docker.com/ login in > clicking on your picture (top-right corner) > My profile and under the repositories tap should be a "<your_username>/lab-java4j"
        10. inside the imaqe you can get the latest tag by going in the "Tags" tab and copying the version image tag.
---
Trigger
```yaml
on:
  push:
    branches: [master]
```

After mastering the GitHub workflow, you'll be ready to implement observability in the deployed application using Prometheus, which is the final part of this lab.

## 3. Prometheus Observability

In the final section, you'll integrate Prometheus for observability, which is crucial for monitoring the health and performance of your application. Observability allows you to understand the internal state of your application based on the data it generates, which is vital for maintaining resilient and reliable services.

**Key Objectives:**

- Integrate Prometheus with the Java application.
- Set up metrics collection to monitor application performance.
- Visualize the data in Grafana to gain insights into the application's behavior.

## Conclusion

By the end of this lab, you will have a robust Java application equipped with resilience patterns, automated CI/CD workflows using GitHub, and comprehensive observability through Prometheus. Each section is designed to build on the previous one, so be sure to complete them in the order provided.

Good luck, and enjoy the hands-on experience!

For more detailed instructions and specific configuration steps, please refer to the individual guides provided in each section.
****