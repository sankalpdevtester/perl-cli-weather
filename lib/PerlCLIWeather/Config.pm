package PerlCLIWeather::Config;

use strict;
use warnings;
use Mojo::Base 'Mojo::Config';

sub new {
    my $self = shift->SUPER::new(@_);
    $self->parse('.env.example') if -f '.env.example';
    return $self;
}

sub get_openweathermap_api_key {
    my $self = shift;
    return $self->param('OPENWEATHERMAP_API_KEY');
}

sub get_openweathermap_api_base_url {
    my $self = shift;
    return $self->param('OPENWEATHERMAP_API_BASE_URL') || 'https://api.openweathermap.org/data/2.5';
}

sub get_default_units {
    my $self = shift;
    return $self->param('DEFAULT_UNITS') || 'metric';
}

1;