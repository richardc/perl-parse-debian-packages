#!perl -w
use strict;
use Test::More tests => 3;
use Parse::Debian::Packages;
open my $fh, "<sample" or die "couldn't open sample: $!";

my $parser = Parse::Debian::Packages->new($fh);
isa_ok( $parser, "Parse::Debian::Packages" );
my %first = $parser->next;
ok( %first, "fetched one" );
is( $first{Version}, "0.8.1-10", "parsed version" );
use YAML;
print Dump \%first;
