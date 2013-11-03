
package WWW::Kickstarter::Error;

use strict;
use warnings;
no autovivification;


use Exporter qw( import );
our @EXPORT_OK = qw( my_croak );


use Carp qw( );


use overload '""' => \&as_string;


$Carp::CarpInternal{ (__PACKAGE__) } = 1;

{
   my @pkgs = qw(
      WWW::Kickstarter
      WWW::Kickstarter::Categories
      WWW::Kickstarter::Category
      WWW::Kickstarter::Error
      WWW::Kickstarter::HttpClient
      WWW::Kickstarter::Iterator
      WWW::Kickstarter::JsonParser
      WWW::Kickstarter::NotificationPref
      WWW::Kickstarter::Object
      WWW::Kickstarter::Project
      WWW::Kickstarter::User
      WWW::Kickstarter::User::Myself
   );
   
   my $code = join '', map "package $_; our \@CARP_NOT = \@pkgs;\n", @pkgs;
   eval $code."1" or die $@;
}   


sub my_croak {
   my ($code, $message) = @_;
   die __PACKAGE__->new($code, $message);
}


sub new {
   my ($class, $code, $message) = @_;
   my $self = bless({}, $class);
   $self->{code   } = $code;
   $self->{message} = $message;
   $self->{trace  } = Carp::shortmess('');
   return $self;
}


sub code    { $_[0]{code} }
sub message { $_[0]{message} }

sub as_string { $_[0]{message} . $_[0]{trace} }


1;


__END__

=head1 NAME

WWW::Kickstarter::Error - ~~~


=head1 SYNOPSIS

   ~~~


=head1 DESCRIPTION

~~~


=head1 SUBROUTINES

   my_croak($code, $message);

~~~


=head1 CONSTRUCTOR

   my $error = WWW::Kickstarter::Error->new($code, $message);

~~~


=head1 ACCESSORS

=head2 code

   my $code = $error->code();

One of the following:

=over

=item * C<400> to C<499>

Invalid arguments provided.

=item * C<401>

Authentication failure. The user does not exist, or an incorrect password was supplied.

=item * C<404>

The specified user, project or category does not exist.

=item * C<500> to C<599>

A communication error or an unrecognized response.

=back



=head2 message

   my $message = $error->message();

~~~


=head2 as_string

   my $message = $error->as_string();
   my $message = "$error";

~~~


=head1 EXPORTS

The following are exported on demand:

=over

=item * C<my_croak>

=back


=head1 VERSION, BUGS, KNOWN ISSUES, SUPPORT, AUTHORS, COPYRIGHT & LICENSE

See L<WWW::Kickstarter>


=cut
