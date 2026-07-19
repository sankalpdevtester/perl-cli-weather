package PerlCLIWeather::LocationManager;

use strict;
use warnings;
use PerlCLIWeather::Location;
use PerlCLIWeather::Config;
use PerlCLIWeather::Cache;

sub new {
    my ($class) = @_;
    my $self = bless {
        cache => PerlCLIWeather::Cache->new(),
    }, $class;
    return $self;
}

sub add_location {
    my ($self, $location) = @_;
    if ($location->validate()) {
        $self->{cache}->set($location->get_name(), $location->to_hash());
        return 1;
    }
    return 0;
}

sub get_location {
    my ($self, $name) = @_;
    my $hash = $self->{cache}->get($name);
    if ($hash) {
        return PerlCLIWeather::Location->from_hash($hash);
    }
    return undef;
}

sub get_all_locations {
    my ($self) = @_;
    my @locations;
    foreach my $name ($self->{cache}->keys()) {
        my $hash = $self->{cache}->get($name);
        push @locations, PerlCLIWeather::Location->from_hash($hash);
    }
    return @locations;
}

sub remove_location {
    my ($self, $name) = @_;
    $self->{cache}->remove($name);
}

1;