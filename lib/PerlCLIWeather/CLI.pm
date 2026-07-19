package PerlCLIWeather::CLI;

use strict;
use warnings;
use Getopt::Long;
use PerlCLIWeather::OpenWeatherMap;
use PerlCLIWeather::Config;

sub new {
    my ($class, $config) = @_;
    my $self = bless {}, $class;
    $self->{config} = $config;
    $self->{openweathermap} = PerlCLIWeather::OpenWeatherMap->new($config);
    return $self;
}

sub run {
    my ($self) = @_;
    GetOptions(
        "location=s" => \$self->{location},
        "units=s" => \$self->{units},
        "forecast" => \$self->{forecast},
    );
    if (!$self->{location}) {
        die "Please specify a location";
    }
    if ($self->{forecast}) {
        $self->display_forecast;
    } else {
        $self->display_current_weather;
    }
}

sub display_current_weather {
    my ($self) = @_;
    my $weather = $self->{openweathermap}->get_current_weather($self->{location});
    print "Current weather in $self->{location}:\n";
    print "Temperature: " . $weather->{main}->{temp} . " " . $self->{config}->get('units') . "\n";
    print "Humidity: " . $weather->{main}->{humidity} . "%\n";
    print "Conditions: " . $weather->{weather}->[0]->{description} . "\n";
}

sub display_forecast {
    my ($self) = @_;
    my $forecast = $self->{openweathermap}->get_forecast($self->{location});
    print "Forecast for $self->{location}:\n";
    foreach my $forecast_item (@{$forecast->{list}}) {
        print "Date: " . $forecast_item->{dt_txt} . "\n";
        print "Temperature: " . $forecast_item->{main}->{temp} . " " . $self->{config}->get('units') . "\n";
        print "Humidity: " . $forecast_item->{main}->{humidity} . "%\n";
        print "Conditions: " . $forecast_item->{weather}->[0]->{description} . "\n";
        print "\n";
    }
}

1;