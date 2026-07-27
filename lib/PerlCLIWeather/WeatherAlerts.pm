package PerlCLIWeather::WeatherAlerts;

use Mojo::Base 'Mojolicious::Controller';
use PerlCLIWeather::Config;
use PerlCLIWeather::OpenWeatherMap;
use PerlCLIWeather::Cache;

sub new {
    my $self = shift->SUPER::new(@_);
    return $self;
}

sub get_weather_alerts {
    my $self = shift;
    my $location = shift;

    # Get OpenWeatherMap API key from config
    my $api_key = PerlCLIWeather::Config->new->get_openweathermap_api_key;

    # Create OpenWeatherMap API client
    my $openweathermap = PerlCLIWeather::OpenWeatherMap->new($api_key);

    # Get current weather conditions
    my $weather = $openweathermap->get_weather($location);

    # Check if there are any weather alerts
    if ($weather->{alerts}) {
        my @alerts;
        foreach my $alert (@{$weather->{alerts}}) {
            push @alerts, {
                event => $alert->{event},
                description => $alert->{description},
                start => $alert->{start},
                end => $alert->{end},
            };
        }
        return @alerts;
    } else {
        return [];
    }
}

sub notify_weather_alerts {
    my $self = shift;
    my $location = shift;

    # Get weather alerts
    my @alerts = $self->get_weather_alerts($location);

    # Print weather alerts
    if (@alerts) {
        print "Weather Alerts for $location:\n";
        foreach my $alert (@alerts) {
            print "  - Event: $alert->{event}\n";
            print "    Description: $alert->{description}\n";
            print "    Start: $alert->{start}\n";
            print "    End: $alert->{end}\n";
        }
    } else {
        print "No weather alerts for $location.\n";
    }
}

1;
```

```perl
# In lib/PerlCLIWeather/CLI.pm
package PerlCLIWeather::CLI;

use Mojo::Base 'Mojolicious::Command';
use PerlCLIWeather::WeatherAlerts;

sub call {
    my ($self, @args) = @_;

    # Add new command for weather alerts
    my $app = $self->app;
    $app->commands->add(
        'weather-alerts' => sub {
            my ($self, @args) = @_;
            my $location = shift @args;
            my $weather_alerts = PerlCLIWeather::WeatherAlerts->new;
            $weather_alerts->notify_weather_alerts($location);
        }
    );
}

1;