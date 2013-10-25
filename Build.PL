use strict;
use warnings;

use Module::Build qw( );

my $build = Module::Build->new(
   module_name => 'WWW::Kickstarter',
   dist_author => 'Eric Brine <ikegami@adaelis.com>',
   license     => 'CC0_1_0',
   configure_requires => {
      'Module::Build'              => 0.36_14,
      'Software::License::CC0_1_0' => 0,
   },
   build_requires => {
      'Test::More' => 0,
   },
   requires => {
      'JSON'                 => 0,
      #'JSON:XS'             => 0,  # Recommended
      'LWP::Protocol::https' => 0,
      'LWP::UserAgent'       => 0,
      'version'              => 0,
   },
   add_to_cleanup => [ 'WWW-Kickstarter-*' ],
   meta_merge     => {
      resources => {
         repository => "http://github.com/ikegami/perl-WWW-Kickstarter",
      }
   },
);

$build->create_build_script();
