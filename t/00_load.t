#!perl -T

use strict;
use warnings;

use Test::More tests => 1;

BEGIN { require_ok( 'LWP::Protocol::AnyEvent::http' ); }

diag( "Testing WWW::Kickstarter $WWW::Kickstarter::VERSION" );
diag( "Using Perl $]" );

for (sort grep /\.pm\z/, keys %INC) {
   s/\.pm\z//;
   s!/!::!g;
   eval { diag(join(' ', $_, $_->VERSION || '<unknown>')) };
}
