use strict;
use warnings;
use Test::More;
use PerlCLIWeather::OpenWeatherMap;
use PerlCLIWeather::Config;

my $config = PerlCLIWeather::Config->new;
my $openweathermap = PerlCLIWeather::OpenWeatherMap->new($config);

subtest "get_current_weather" => sub {
    my $weather = $openweathermap->get_current_weather("London");
    ok($weather, "Got weather data");
    is(ref($weather), "HASH", "Weather data is a hash");
    ok(exists $weather->{main}, "Weather data has main key");
    ok(exists $weather->{weather}, "Weather data has weather key");
};

subtest "get_forecast" => sub {
    my $forecast = $openweathermap->get_forecast("London");
    ok($forecast, "Got forecast data");
    is(ref($forecast), "HASH", "Forecast data is a hash");
    ok(exists $forecast->{list}, "Forecast data has list key");
    ok(ref($forecast->{list}) eq "ARRAY", "Forecast data list is an array");
};

done_testing;