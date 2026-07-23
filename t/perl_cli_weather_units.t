use strict;
use warnings;
use Test::More;
use PerlCLIWeather::UnitConverter;

my $converter = PerlCLIWeather::UnitConverter->new;

subtest 'temperature conversion' => sub {
    is($converter->convert_temperature(0, 'celsius', 'fahrenheit'), 32, '0°C is 32°F');
    is($converter->convert_temperature(100, 'celsius', 'fahrenheit'), 212, '100°C is 212°F');
    is($converter->convert_temperature(32, 'fahrenheit', 'celsius'), 0, '32°F is 0°C');
    is($converter->convert_temperature(212, 'fahrenheit', 'celsius'), 100, '212°F is 100°C');
};

subtest 'wind speed conversion' => sub {
    is($converter->convert_wind_speed(1, 'm/s', 'mph'), 2.23694, '1 m/s is 2.23694 mph');
    is($converter->convert_wind_speed(1, 'mph', 'm/s'), 0.44704, '1 mph is 0.44704 m/s');
};

subtest 'pressure conversion' => sub {
    is($converter->convert_pressure(1013, 'hPa', 'inHg'), 29.92, '1013 hPa is 29.92 inHg');
    is($converter->convert_pressure(29.92, 'inHg', 'hPa'), 1013, '29.92 inHg is 1013 hPa');
};

done_testing;