#!/bin/bash

# Base URL for the API endpoints
HOST='app:8080'
ENDPOINT='/api/v1/resilience'

# Function to perform 30 simultaneous POST requests
function call_post_simultaneous() {
    echo "Calling POST endpoint with 50 simultaneous requests..."
    for i in {1..50}; do
        STATUS=$(curl --silent --output /dev/null --write-out "%{http_code}" \
            --data '{"data": "test '$i'"}' \
            --header "Content-Type: application/json" \
            --request POST "${HOST}${ENDPOINT}")
        echo "Call '$i': $STATUS"
    done
    wait  # Wait for all background jobs to finish
    echo -e "\n50 POST requests completed."
}

# Function to perform GET request with an optional delay
function call_get_with_delay() {
    DELAY_CHANCE=`expr $RANDOM % 100 + 1`

    if [ $DELAY_CHANCE -le 30 ]; then
        # 15% chance to call with a delay
        echo "Calling GET endpoint with a delay..."
        STATUS=$(curl --silent --output /dev/null --write-out "%{http_code}" "${HOST}${ENDPOINT}?delay=true")
        echo "GET request (with delay) completed with status: $STATUS"
    else
        # 40% chance to call without a delay
        echo "Calling GET endpoint without a delay..."
        STATUS=$(curl --silent --output /dev/null --write-out "%{http_code}" "${HOST}${ENDPOINT}?delay=false")
        echo "GET request (without delay) completed with status: $STATUS"
    fi
}

# Function to perform a PUT request with varying payload sizes
function call_put_with_varying_payloads() {
    echo "Calling PUT endpoint..."
    STATUS=$(curl --silent --output /dev/null --write-out "%{http_code}" \
        --data '{"data": "short payload"}' \
        --header "Content-Type: application/json" \
        --request PUT "${HOST}${ENDPOINT}")
    echo "PUT request completed with status: $STATUS"
}

while true
do
    # Randomly pick a number between 1 and 100 to decide which scenario to trigger
    NUMB=`expr $RANDOM % 100 + 1`

    # 40% chance to perform GET request with delay
    if [ $NUMB -le 50 ]; then
        call_get_with_delay

    # 30% chance to perform PUT request with varying payload sizes
    elif [ $NUMB -ge 51 ] && [ $NUMB -le 80 ]; then
        call_put_with_varying_payloads

    # 10% chance to perform 30 simultaneous POST requests
    elif [ $NUMB -ge 81 ] && [ $NUMB -le 90 ]; then
        call_post_simultaneous

    # 5% chance to perform a POST request with invalid data
    elif [ $NUMB -ge 91 ] && [ $NUMB -le 95 ]; then
        echo "Calling POST with invalid data"
        STATUS=$(curl --silent --output /dev/null --write-out "%{http_code}" \
            --data '{"data":""}' \
            --header "Content-Type: application/json" \
            --request POST "${HOST}${ENDPOINT}")
        echo "POST request (invalid data) completed with status: $STATUS"

    # 5% chance to call an invalid endpoint to simulate 404 errors
    else
        echo "Calling invalid GET ${HOST}${ENDPOINT}/invalid"
        STATUS=$(curl --silent --output /dev/null --write-out "%{http_code}" "${HOST}${ENDPOINT}/invalid")
        echo "Invalid GET request completed with status: $STATUS"
    fi

    sleep 0.5  # Adjust the sleep time between requests
done
