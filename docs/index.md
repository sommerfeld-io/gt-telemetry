<!-- ---
hide:
  - navigation
--- -->

# Gran Turismo 7 Telemetry

[doc-website]: https://sommerfeld-io.github.io/gt-telemetry
[github-repo]: https://github.com/sommerfeld-io/gt-telemetry
[file-issues]: https://github.com/sommerfeld-io/gt-telemetry/issues

This project is a [Gran Turismo 7](https://www.gran-turismo.com/us/gt7/top) Telemetry Dashboard that allows you to view telemetry data from the game in real-time.

- [Documentation Website][doc-website]
- [Github Repository][github-repo]
- [Where to file issues][file-issues]

## Requirements and Features

<!-- TODO link the GitHub story -->

The racing dashboard should display information about the current race, the car, and the track. It is not aimed at providing a lap by lap analysis, but rather a real-time overview of the current racing situation.

- Show current race position (e.g. 5/20 meaning you are running in 5th place out of 20 cars)
- Show current lap and total laps
- Show current lap time and personal best lap time
- Show fastest lap time of the race and who set it
- Show current speed
- Show current gear
- Show current RPM
- Show current throttle and brake input
- Show current tire wear
- Show current tire temperature
- Show current fuel level

The lap by lap analysis dashboard should provide a detailed analysis of each lap driven during the race. It should allow the user to compare lap times, sector times, and other telemetry data between laps. A user should be able to compare throttle and brake inputs, RPM, speed, and other data between laps. -->

<!-- TODO link the GitHub story -->

## Usage

To use the telemetry dashboard, you need to have a computer or Raspberry Pi running Docker. The app aimed to run on x86 and ARM architectures. The Docker images are NOT published to Docker Hub or any other registry. You need to build the images yourself. Use the `docker-compose.yml` file to build and run the app.

```bash
docker compose build
docker compose up
```

The dashboard is available at `http://localhost:8000`.

### Enable Telemetry Broadcasting in GT7

In Gran Turismo 7, go to *Options > Controller Settings > Output Mode Settings* and enable *UDP broadcasting*.

It is recommended to set a static IP address for your PS5 in your router settings. This way, the IP address of the PS5 does not change, and you do not have to reconfigure the telemetry adapter every time the IP address changes.

## Architecture Constraints

- Reading data from the Game is done via UDP
    - Gran Turismo 7 does not officially provide a public API for external integrations, but there are mechanisms for accessing real-time telemetry data via the UDP (User Datagram Protocol) telemetry broadcasting feature built into the game. This feature is commonly used for creating dashboards, sim rigs, or external visualizations.
    - The *UDP telemetry broadcasting* feature in Gran Turismo 7 (GT7) allows the game to send real-time telemetry data over your local network to an external application or device.

## Building Block View

The Telemetry Adapter is written in Golang. Prometheus and Grafana are used as-is. They only carry datasource and dashboard configurations.

```kroki-plantuml
@startuml

skinparam linetype ortho
skinparam monochrome false
skinparam componentStyle uml2
skinparam backgroundColor transparent
skinparam arrowColor black
skinparam NoteBackgroundColor #eee
skinparam activity {
    'FontName Ubuntu
    FontName Roboto
}

component ps5 as "PS5" {
    control api as "UDP Telemetry" <<API>>
}

rectangle Consumer {
    component ta as "Telemetry Adapter" <<Docker Container>>
    component Prometheus <<Docker Container>>
    component Grafana <<Docker Container>>
}

note bottom of Consumer: Computer or RasPi

api <-right- ta
api -right-> ta
ta -down-> Prometheus
Prometheus -down-> Grafana

@enduml
```

## Contact

Feel free to contact me via <sebastian@sommerfeld.io> or [raise an issue in this repository][file-issues].
