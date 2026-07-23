package PerlCLIWeather::UnitConverter;

use strict;
use warnings;

sub convert_temperature {
    my ($self, $temperature, $from_unit, $to_unit) = @_;
    if ($from_unit eq 'celsius' && $to_unit eq 'fahrenheit') {
        return $temperature * 9/5 + 32;
    } elsif ($from_unit eq 'fahrenheit' && $to_unit eq 'celsius') {
        return ($temperature - 32) * 5/9;
    } else {
        return $temperature;
    }
}

sub convert_wind_speed {
    my ($self, $wind_speed, $from_unit, $to_unit) = @_;
    if ($from_unit eq 'm/s' && $to_unit eq 'mph') {
        return $wind_speed * 2.23694;
    } elsif ($from_unit eq 'mph' && $to_unit eq 'm/s') {
        return $wind_speed * 0.44704;
    } else {
        return $wind_speed;
    }
}

sub convert_pressure {
    my ($self, $pressure, $from_unit, $to_unit) = @_;
    if ($from_unit eq 'hPa' && $to_unit eq 'inHg') {
        return $pressure * 0.02953;
    } elsif ($from_unit eq 'inHg' && $to_unit eq 'hPa') {
        return $pressure * 33.86;
    } else {
        return $pressure;
    }
}

1;