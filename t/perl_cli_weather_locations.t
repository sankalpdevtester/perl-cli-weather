use strict;
use warnings;
use Test::More;
use PerlCLIWeather::Location;
use PerlCLIWeather::LocationManager;

my $location_manager = PerlCLIWeather::LocationManager->new();

my $location = PerlCLIWeather::Location->new('New York', 40.7128, 74.0060);
ok($location_manager->add_location($location), 'add location');

my $retrieved_location = $location_manager->get_location('New York');
is($retrieved_location->get_name(), 'New York', 'get location');
is($retrieved_location->get_lat(), 40.7128, 'get lat');
is($retrieved_location->get_lon(), 74.0060, 'get lon');

my @locations = $location_manager->get_all_locations();
is(scalar @locations, 1, 'get all locations');

$location_manager->remove_location('New York');
my $removed_location = $location_manager->get_location('New York');
is($removed_location, undef, 'remove location');

done_testing();