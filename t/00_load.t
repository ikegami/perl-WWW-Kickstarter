#!perl -T

use strict;
use warnings;

use Test::More tests => 12;

BEGIN {
   require_ok( 'WWW::Kickstarter'                     );
   require_ok( 'WWW::Kickstarter::Categories'         );
   require_ok( 'WWW::Kickstarter::Category'           );
   require_ok( 'WWW::Kickstarter::Error'              );
   require_ok( 'WWW::Kickstarter::HttpClient::Lwp'    );
   require_ok( 'WWW::Kickstarter::Iterator'           );
   require_ok( 'WWW::Kickstarter::JsonParser::JsonXs' );
   require_ok( 'WWW::Kickstarter::NotificationPref'   );
   require_ok( 'WWW::Kickstarter::Object'             );
   require_ok( 'WWW::Kickstarter::Project'            );
   require_ok( 'WWW::Kickstarter::User'               );
   require_ok( 'WWW::Kickstarter::User::Myself'       );
}

diag( "Testing WWW::Kickstarter $WWW::Kickstarter::VERSION" );
diag( "Using Perl $]" );

for (sort grep /\.pm\z/, keys %INC) {
   s/\.pm\z//;
   s!/!::!g;
   eval { diag(join(' ', $_, $_->VERSION || '<unknown>')) };
}
