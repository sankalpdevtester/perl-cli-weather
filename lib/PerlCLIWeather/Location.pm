package PerlCLIWeather::Location;

use strict;
use warnings;
use PerlCLIWeather::Config;

sub new {
    my ($class, $name, $lat, $lon) = @_;
    my $self = bless {
        name => $name,
        lat  => $lat,
        lon  => $lon,
    }, $class;
    return $self;
}

sub get_name {
    my ($self) = @_;
    return $self->{name};
}

sub get_lat {
    my ($self) = @_;
    return $self->{lat};
}

sub get_lon {
    my ($self) = @_;
    return $self->{lon};
}

sub validate {
    my ($self) = @_;
    if (!$self->{name} || !$self->{lat} || !$self->{lon}) {
        return 0;
    }
    return 1;
}

sub to_hash {
    my ($self) = @_;
    return {
        name => $self->{name},
        lat  => $self->{lat},
        lon  => $self->{lon},
    };
}

sub from_hash {
    my ($class, $hash) = @_;
    return $class->new($hash->{name}, $hash->{lat}, $hash->{lon});
}

1;