# Observability with Grafana

Grafana is an open-source platform for monitoring and observability. 
It allows you to query, visualize, alert on, and understand your metrics no matter where they are stored. 
In this guide, you will learn how to set up Grafana to monitor your applications and infrastructure.

## Docker

The easiest way to get started with Grafana is to use Docker. 
You can run Grafana in a Docker container and access it through your web browser.
In this project, Grafana is running in a Docker container alongside Prometheus.

## How to use the Grafana

Access Grafana by visiting `http://localhost:3000` in your web browser.  

The default username and password are `admin`.

# Add metric panels to the advanced dashboard

On the adv_dash.json add the following panels where it says **//ADD NEW PANELS HERE**

### Circuit break closed state
```json
{
  "cacheTimeout": null,
  "colorBackground": false,
  "colorPostfix": false,
  "colorPrefix": false,
  "colorValue": true,
  "colors": [
    "#d44a3a",
    "rgba(237, 129, 40, 0.89)",
    "#73BF69"
  ],
  "datasource": "prometheus",
  "format": "none",
  "gauge": {
    "maxValue": 2,
    "minValue": 0,
    "show": false,
    "thresholdLabels": false,
    "thresholdMarkers": true
  },
  "gridPos": {
    "h": 5,
    "w": 12,
    "x": 0,
    "y": 1
  },
  "id": 8,
  "interval": null,
  "links": [],
  "mappingType": 1,
  "mappingTypes": [
    {
      "name": "value to text",
      "value": 1
    },
    {
      "name": "range to text",
      "value": 2
    }
  ],
  "maxDataPoints": 100,
  "nullPointMode": "connected",
  "nullText": null,
  "postfix": "",
  "postfixFontSize": "50%",
  "prefix": "CLOSED:",
  "prefixFontSize": "50%",
  "rangeMaps": [
    {
      "from": "null",
      "text": "N/A",
      "to": "null"
    }
  ],
  "sparkline": {
    "fillColor": "rgba(150, 217, 141, 0.22)",
    "full": false,
    "lineColor": "#73BF69",
    "show": true
  },
  "tableColumn": "",
  "targets": [
    {
      "expr": "sum(resilience4j_circuitbreaker_state{state=\"closed\"})",
      "format": "time_series",
      "instant": false,
      "intervalFactor": 1,
      "refId": "A"
    }
  ],
  "thresholds": "0,1",
  "timeFrom": null,
  "timeShift": null,
  "title": "Number of closed CircuitBreaker",
  "type": "singlestat",
  "valueFontSize": "100%",
  "valueMaps": [
    {
      "op": "=",
      "text": "N/A",
      "value": "null"
    }
  ],
  "valueName": "current"
}
```

### Circuit break half_open state
```json
{
  "cacheTimeout": null,
  "colorBackground": false,
  "colorPostfix": false,
  "colorPrefix": false,
  "colorValue": true,
  "colors": [
    "#299c46",
    "rgba(237, 129, 40, 0.89)",
    "#F2495C"
  ],
  "datasource": "prometheus",
  "format": "none",
  "gauge": {
    "maxValue": 100,
    "minValue": 0,
    "show": false,
    "thresholdLabels": false,
    "thresholdMarkers": false
  },
  "gridPos": {
    "h": 5,
    "w": 12,
    "x": 12,
    "y": 1
  },
  "id": 6,
  "interval": null,
  "links": [],
  "mappingType": 1,
  "mappingTypes": [
    {
      "name": "value to text",
      "value": 1
    },
    {
      "name": "range to text",
      "value": 2
    }
  ],
  "maxDataPoints": 100,
  "nullPointMode": "connected",
  "nullText": null,
  "postfix": "",
  "postfixFontSize": "50%",
  "prefix": "OPEN: ",
  "prefixFontSize": "50%",
  "rangeMaps": [
    {
      "from": "null",
      "text": "N/A",
      "to": "null"
    }
  ],
  "sparkline": {
    "fillColor": "#FFA6B0",
    "full": false,
    "lineColor": "#F2495C",
    "show": true
  },
  "tableColumn": "",
  "targets": [
    {
      "expr": "sum(resilience4j_circuitbreaker_state{state=~\"open|forced_open\"})",
      "format": "time_series",
      "intervalFactor": 1,
      "refId": "A"
    }
  ],
  "thresholds": "1,5",
  "timeFrom": null,
  "timeShift": null,
  "title": "Number of open CircuitBreaker",
  "type": "singlestat",
  "valueFontSize": "100%",
  "valueMaps": [
    {
      "op": "=",
      "text": "N/A",
      "value": "null"
    }
  ],
  "valueName": "current"
},
```

### Circuit break open state
```json
{
  "cacheTimeout": null,
  "colorBackground": false,
  "colorValue": true,
  "colors": [
    "#299c46",
    "#FF9830",
    "#d44a3a"
  ],
  "datasource": "prometheus",
  "format": "none",
  "gauge": {
    "maxValue": 100,
    "minValue": 0,
    "show": false,
    "thresholdLabels": false,
    "thresholdMarkers": true
  },
  "gridPos": {
    "h": 7,
    "w": 12,
    "x": 12,
    "y": 6
  },
  "id": 21,
  "interval": null,
  "links": [],
  "mappingType": 1,
  "mappingTypes": [
    {
      "name": "value to text",
      "value": 1
    },
    {
      "name": "range to text",
      "value": 2
    }
  ],
  "maxDataPoints": 100,
  "nullPointMode": "connected",
  "nullText": null,
  "pluginVersion": "6.1.6",
  "postfix": "",
  "postfixFontSize": "50%",
  "prefix": "HALF_OPEN: ",
  "prefixFontSize": "50%",
  "rangeMaps": [
    {
      "from": "null",
      "text": "N/A",
      "to": "null"
    }
  ],
  "sparkline": {
    "fillColor": "rgba(31, 118, 189, 0.18)",
    "full": false,
    "lineColor": "rgb(31, 120, 193)",
    "show": true
  },
  "tableColumn": "",
  "targets": [
    {
      "expr": "sum(resilience4j_circuitbreaker_state{state=\"half_open\"})",
      "format": "time_series",
      "instant": false,
      "intervalFactor": 1,
      "legendFormat": "",
      "refId": "A"
    }
  ],
  "thresholds": "0,1",
  "timeFrom": null,
  "timeShift": null,
  "title": "Number of half_open CircuitBreaker",
  "type": "singlestat",
  "valueFontSize": "100%",
  "valueMaps": [
    {
      "op": "=",
      "text": "N/A",
      "value": "null"
    }
  ],
  "valueName": "current"
},
```