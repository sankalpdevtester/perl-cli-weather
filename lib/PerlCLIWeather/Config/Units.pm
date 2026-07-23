package PerlCLIWeather::Config::Units;

use strict;
use warnings;
use Config::Tiny;

sub new {
    my ($self) = @_;
    my $config = Config::Tiny->new;
    $config->read('config.ini');
    $self->{config} = $config;
}

sub get_units {
    my ($self) = @_;
    my $units = $self->{config}->{units};
    return $units;
}

sub set_units {
    my ($self, $units) = @_;
    $self->{config}->{units} = $units;
    $self->{config}->write('config.ini');
}

sub get_temperature_unit {
    my ($self) = @_;
    my $units = $self->get_units;
    return $units->{temperature};
}

sub get_wind_speed_unit {
    my ($self) = @_;
    my $units = $self->get_units;
    return $units->{wind_speed};
}

sub get_pressure_unit {
    my ($self) = @_;
    my $units = $self->get_units;
    return $units->{pressure};
}

1;