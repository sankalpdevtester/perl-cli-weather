package PerlCLIWeather::Error;

use strict;
use warnings;
use Mojo::Base 'Mojo::Exception';

sub new {
    my ($self, $message) = @_;
    $self->SUPER::new($message);
}

sub api_error {
    my ($self, $response) = @_;
    my $error = {
        status => $response->code,
        message => $response->message,
    };
    return $error;
}

sub invalid_response {
    my ($self, $response) = @_;
    my $error = {
        status => 500,
        message => 'Invalid response from API',
    };
    return $error;
}

sub connection_error {
    my ($self, $error) = @_;
    my $error_obj = {
        status => 500,
        message => 'Connection error: ' . $error,
    };
    return $error_obj;
}

1;