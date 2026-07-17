# Perl CLI Weather Tool
A command-line tool for retrieving and displaying current weather conditions, used by individuals who want to quickly check the weather from their terminal.

## Badges
[![Language](https://img.shields.io/badge/Language-Perl-ff69b4)](https://www.perl.org/)
[![License](https://img.shields.io/badge/License-MIT-8d499e)](https://opensource.org/licenses/MIT)

## What it does
The Perl CLI Weather Tool is a simple command-line application that retrieves and displays current weather conditions. It utilizes the OpenWeatherMap API to fetch weather data and supports multiple locations. The tool also features error handling for API requests and configurable units.

## Features
* Display current weather conditions
* Display forecast for a specified location
* Support for multiple locations
* Error handling for API requests
* Configurable units (Celsius or Fahrenheit)

## Requirements
* Perl 5.32
* Mojolicious
* OpenWeatherMap API key

## Installation
To install the required dependencies, run the following command:
```bash
cpanm -n Mojolicious
```
Then, clone the repository and navigate to the project directory.

## Usage
To run the application, use the following command:
```bash
morbo script/perl_cli_weather
```
Example usage:
```bash
# Display current weather in London
curl http://localhost:3000/weather?location=London

# Display forecast for New York
curl http://localhost:3000/forecast?location=New York

# Display current weather in Celsius
curl http://localhost:3000/weather?location=London&units=celsius
```
Expected output:
```json
{
  "location": "London",
  "temperature": 22,
  "conditions": "Sunny"
}
```

## Environment Variables
| Variable | Description |
| --- | --- |
| `OPENWEATHERMAP_API_KEY` | OpenWeatherMap API key |
| `DEFAULT_LOCATION` | Default location for weather queries |
| `DEFAULT_UNITS` | Default units for temperature (celsius or fahrenheit) |

## Project Structure
```markdown
perl_cli_weather/
├── script
│   └── perl_cli_weather
├── lib
│   ├── PerlCLIWeather
│   │   ├── Controller
│   │   │   └── Weather.pm
│   │   └── Model
│   │       └── OpenWeatherMap.pm
│   └── PerlCLIWeather.pm
├── t
│   └── perl_cli_weather.t
├── README.md
└── LICENSE
```

## Contributing
Contributions are welcome! To contribute, please fork the repository, make your changes, and submit a pull request. Ensure that your code is formatted according to the Perl coding standards and includes tests for any new functionality.

## License
This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.