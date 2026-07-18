#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use PerlCLIWeather::Config;
use PerlCLIWeather::Weather;

my $config = PerlCLIWeather::Config->new;
my $weather = PerlCLIWeather::Weather->new;

subtest 'get_openweathermap_api_key' => sub {
    my $api_key = $config->get_openweathermap_api_key;
    ok($api_key, 'API key is set');
};

subtest 'get_openweathermap_api_base_url' => sub {
    my $api_base_url = $config->get_openweathermap_api_base_url;
    ok($api_base_url, 'API base URL is set');
};

subtest 'get_default_units' => sub {
    my $default_units = $config->get_default_units;
    ok($default_units, 'Default units are set');
};

subtest 'get_current_weather' => sub {
    my $location = 'London';
    my $current_weather = $weather->get_current_weather($location);
    ok($current_weather, 'Current weather data is retrieved');
    ok($current_weather->{main}, 'Main weather data is present');
    ok($current_weather->{weather}, 'Weather data is present');
};

subtest 'get_forecast' => sub {
    my $location = 'London';
    my $forecast = $weather->get_forecast($location);
    ok($forecast, 'Forecast data is retrieved');
    ok($forecast->{list}, 'Forecast list is present');
};

done_testing();