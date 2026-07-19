package PerlCLIWeather::OpenWeatherMap;

use strict;
use warnings;
use Mojo::UserAgent;
use PerlCLIWeather::Config;

sub new {
    my ($class, $config) = @_;
    my $self = bless {}, $class;
    $self->{config} = $config;
    $self->{ua} = Mojo::UserAgent->new;
    return $self;
}

sub get_current_weather {
    my ($self, $location) = @_;
    my $api_key = $self->{config}->get('openweathermap_api_key');
    my $url = "http://api.openweathermap.org/data/2.5/weather";
    my $params = {
        q => $location,
        units => $self->{config}->get('units'),
        APPID => $api_key,
    };
    my $tx = $self->{ua}->get($url => form => $params);
    my $res = $tx->result;
    if ($res->is_success) {
        return $res->json;
    } else {
        die "Failed to retrieve weather data: " . $res->message;
    }
}

sub get_forecast {
    my ($self, $location) = @_;
    my $api_key = $self->{config}->get('openweathermap_api_key');
    my $url = "http://api.openweathermap.org/data/2.5/forecast";
    my $params = {
        q => $location,
        units => $self->{config}->get('units'),
        APPID => $api_key,
    };
    my $tx = $self->{ua}->get($url => form => $params);
    my $res = $tx->result;
    if ($res->is_success) {
        return $res->json;
    } else {
        die "Failed to retrieve forecast data: " . $res->message;
    }
}

1;