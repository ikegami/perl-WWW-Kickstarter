#!perl

use strict;
use warnings;

use FindBin qw( $RealBin );

use Test::More;

BEGIN {
   if ($ENV{DEVEL_TESTS}) {
      plan tests => 2;
   } else {
      plan skip_all => "Version checks are only performed when DEVEL_TESTS=1";
   }
}

sub slurp_file {
   my ($qfn) = @_;
   open(my $fh, '<', $qfn)
      or die("Can't open \"$qfn\": $!\n");

   local $/;
   return <$fh>;
}

{
   chdir("$RealBin/..") or die $!;

   my $file = slurp_file('lib/WWW/Kickstarter.pm');


    my $version = $file =~ /\bqv\('v([^']*)'\)/
      or die("Can't find version\n");

   my $pod_version = $file =~ /^Version (\S+)/m
      or die("Can't find version in POD\n");

   is($pod_version, $version, "Version in POD matches actual version");

   my @parts = split(/\./, $version);

   ok($parts[1] % 2 == 0, "Version is a release version");
}
