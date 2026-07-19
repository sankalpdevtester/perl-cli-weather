# lib/PerlCLIWeather/Forecast.pm

package PerlCLIWeather::Forecast;

use strict;
use warnings;
use feature 'say';

use PerlCLIWeather::Config;
use PerlCLIWeather::OpenWeatherMap;

sub get_5_day_forecast {
    my ($self, $city) = @_;

    my $config = PerlCLIWeather::Config->new();
    my $api_key = $config->get_api_key();
    my $base_url = $config->get_base_url();

    my $openweathermap = PerlCLIWeather::OpenWeatherMap->new($api_key, $base_url);
    my $forecast_data = $openweathermap->get_5_day_forecast($city);

    return $forecast_data;
}

sub parse_forecast_data {
    my ($self, $forecast_data) = @_;

    my @forecast;
    foreach my $day (@{$forecast_data->{list}}) {
        my $date = $day->{dt};
        my $temp = $day->{main}->{temp};
        my $humidity = $day->{main}->{humidity};
        my $weather = $day->{weather}[0]->{description};

        push @forecast, {
            date => $date,
            temp => $temp,
            humidity => $humidity,
            weather => $weather,
        };
    }

    return \@forecast;
}

sub print_forecast {
    my ($self, $forecast) = @_;

    say "5-Day Weather Forecast:";
    foreach my $day (@{$forecast}) {
        say "Date: " . $day->{date};
        say "Temperature: " . $day->{temp} . "°C";
        say "Humidity: " . $day->{humidity} . "%";
        say "Weather: " . $day->{weather};
        say "---";
    }
}

1;
```

```perl
# script/perl_cli_weather

use strict;
use warnings;
use feature 'say';

use PerlCLIWeather::CLI;
use PerlCLIWeather::Forecast;

my $cli = PerlCLIWeather::CLI->new();
my $forecast = PerlCLIWeather::Forecast->new();

$cli->add_command(
    'forecast',
    sub {
        my ($city) = @_;
        my $forecast_data = $forecast->get_5_day_forecast($city);
        my $parsed_forecast = $forecast->parse_forecast_data($forecast_data);
        $forecast->print_forecast($parsed_forecast);
    },
    'Get 5-day weather forecast for a city',
);

$cli->run();
```

```perl
# lib/PerlCLIWeather/OpenWeatherMap.pm (updated)

sub get_5_day_forecast {
    my ($self, $city) = @_;

    my $url = $self->base_url . "/forecast?q=$city&units=metric&appid=" . $self->api_key;
    my $response = $self->ua->get($url);

    if ($response->is_success) {
        return $response->decoded_content;
    } else {
        die "Failed to retrieve forecast data";
    }
}
```

```perl
# t/perl_cli_weather_forecast.t (new test file)

use strict;
use warnings;
use feature 'say';

use Test::More;
use PerlCLIWeather::Forecast;

my $forecast = PerlCLIWeather::Forecast->new();

subtest 'get_5_day_forecast' => sub {
    my $city = 'London';
    my $forecast_data = $forecast->get_5_day_forecast($city);
    ok($forecast_data, 'Forecast data retrieved successfully');
};

subtest 'parse_forecast_data' => sub {
    my $forecast_data = {
        list => [
            {
                dt => 1643723400,
                main => {
                    temp => 10,
                    humidity => 60,
                },
                weather => [
                    {
                        description => 'Light rain',
                    },
                ],
            },
        ],
    };
    my $parsed_forecast = $forecast->parse_forecast_data($forecast_data);
    ok($parsed_forecast, 'Forecast data parsed successfully');
};

subtest 'print_forecast' => sub {
    my $forecast_data = {
        list => [
            {
                dt => 1643723400,
                main => {
                    temp => 10,
                    humidity => 60,
                },
                weather => [
                    {
                        description => 'Light rain',
                    },
                ],
            },
        ],
    };
    my $parsed_forecast = $forecast->parse_forecast_data($forecast_data);
    $forecast->print_forecast($parsed_forecast);
    ok(1, 'Forecast printed successfully');
};

done_testing();