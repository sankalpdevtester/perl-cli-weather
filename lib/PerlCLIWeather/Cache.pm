package PerlCLIWeather::Cache;

use strict;
use warnings;
use Time::HiRes qw(gettimeofday);
use PerlCLIWeather::Config;

our $cache = {};

sub get {
    my ($key) = @_;
    return $cache->{$key} if exists $cache->{$key} && $cache->{$key}->{expires} > gettimeofday();
    return undef;
}

sub set {
    my ($key, $value, $ttl) = @_;
    $cache->{$key} = {
        value => $value,
        expires => gettimeofday() + $ttl,
    };
}

sub delete {
    my ($key) = @_;
    delete $cache->{$key};
}

sub clear {
    %$cache = ();
}

sub get_ttl {
    my ($key) = @_;
    return $cache->{$key}->{expires} - gettimeofday() if exists $cache->{$key};
    return undef;
}

1;
```

```perl
# In lib/PerlCLIWeather/Weather.pm
package PerlCLIWeather::Weather;

use strict;
use warnings;
use PerlCLIWeather::Cache;
use PerlCLIWeather::Config;
use Mojo::UserAgent;

sub get_weather {
    my ($self, $city) = @_;
    my $cache_key = "weather:$city";
    my $cached_response = PerlCLIWeather::Cache::get($cache_key);
    return $cached_response if $cached_response;

    my $ua = Mojo::UserAgent->new;
    my $url = "http://api.openweathermap.org/data/2.5/weather";
    my $params = {
        q => $city,
        units => 'metric',
        appid => PerlCLIWeather::Config->get('openweathermap_api_key'),
    };

    my $response = $ua->get($url => form => $params)->result;
    if ($response->is_success) {
        my $data = $response->json;
        PerlCLIWeather::Cache::set($cache_key, $data, 300); # cache for 5 minutes
        return $data;
    } else {
        return undef;
    }
}

1;
```

```perl
# In script/perl_cli_weather
use strict;
use warnings;
use PerlCLIWeather::Weather;

my $weather = PerlCLIWeather::Weather->new;
my $city = shift @ARGV;
my $data = $weather->get_weather($city);
if ($data) {
    print "Weather in $city: " . $data->{weather}[0]->{description} . "\n";
    print "Temperature: " . $data->{main}->{temp} . "°C\n";
} else {
    print "Failed to retrieve weather data\n";
}
```

```perl
# In t/perl_cli_weather.t
use strict;
use warnings;
use Test::More;
use PerlCLIWeather::Weather;

my $weather = PerlCLIWeather::Weather->new;
my $city = 'London';
my $data = $weather->get_weather($city);
ok($data, 'Weather data retrieved successfully');
is(ref($data), 'HASH', 'Weather data is a hash');

done_testing();