package PerlCLIWeather::Weather;

use strict;
use warnings;
use Mojo::Base 'Mojo::UserAgent';
use PerlCLIWeather::Config;

sub new {
    my $self = shift->SUPER::new(@_);
    $self->config(PerlCLIWeather::Config->new);
    return $self;
}

sub get_current_weather {
    my ($self, $location) = @_;
    my $api_key = $self->config->get_openweathermap_api_key;
    my $api_base_url = $self->config->get_openweathermap_api_base_url;
    my $units = $self->config->get_default_units;
    my $url = "$api_base_url/weather?q=$location&units=$units&appid=$api_key";
    my $tx = $self->get($url);
    my $weather_data = $tx->result->json;
    return $weather_data;
}

sub get_forecast {
    my ($self, $location) = @_;
    my $api_key = $self->config->get_openweathermap_api_key;
    my $api_base_url = $self->config->get_openweathermap_api_base_url;
    my $units = $self->config->get_default_units;
    my $url = "$api_base_url/forecast?q=$location&units=$units&appid=$api_key";
    my $tx = $self->get($url);
    my $forecast_data = $tx->result->json;
    return $forecast_data;
}

1;