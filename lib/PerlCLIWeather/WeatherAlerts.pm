package PerlCLIWeather::WeatherAlerts;

use strict;
use warnings;
use Mojo::Base 'Mojolicious::Controller';
use PerlCLIWeather::OpenWeatherMap;
use PerlCLIWeather::Cache;
use PerlCLIWeather::Config;

sub new {
    my ($self, $c) = @_;
    $self = $c;
    return $self;
}

sub get_weather_alerts {
    my ($self, $location) = @_;

    # Get OpenWeatherMap API key from config
    my $api_key = PerlCLIWeather::Config->new->get_api_key;

    # Create OpenWeatherMap API object
    my $owm = PerlCLIWeather::OpenWeatherMap->new($api_key);

    # Get current weather conditions
    my $weather_data = $owm->get_weather($location);

    # Check if there are any weather alerts
    if ($weather_data->{alerts}) {
        my @alerts;
        foreach my $alert (@{$weather_data->{alerts}}) {
            push @alerts, {
                event => $alert->{event},
                description => $alert->{description},
                start => $alert->{start},
                end => $alert->{end},
            };
        }
        return \@alerts;
    } else {
        return undef;
    }
}

sub notify_weather_alerts {
    my ($self, $location, $alerts) = @_;

    # Create a notification message
    my $message = "Weather alerts for $location:\n";
    foreach my $alert (@$alerts) {
        $message .= "Event: $alert->{event}\n";
        $message .= "Description: $alert->{description}\n";
        $message .= "Start: $alert->{start}\n";
        $message .= "End: $alert->{end}\n\n";
    }

    # Print the notification message
    print $message;
}

1;
```

```perl
# In lib/PerlCLIWeather/CLI.pm
package PerlCLIWeather::CLI;

use strict;
use warnings;
use Mojo::Base 'Mojolicious::Command';
use PerlCLIWeather::Weather;
use PerlCLIWeather::WeatherAlerts;

sub call {
    my ($self, $location) = @_;

    # Get weather data
    my $weather = PerlCLIWeather::Weather->new->get_weather($location);

    # Get weather alerts
    my $weather_alerts = PerlCLIWeather::WeatherAlerts->new->get_weather_alerts($location);

    # Notify weather alerts
    if ($weather_alerts) {
        PerlCLIWeather::WeatherAlerts->new->notify_weather_alerts($location, $weather_alerts);
    }
}

1;