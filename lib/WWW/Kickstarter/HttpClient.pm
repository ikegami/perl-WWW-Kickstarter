
package WWW::Kickstarter::HttpClient;

die "Place holder for documentation. Not an actual module";

__END__

=head1 NAME

WWW::Kickstarter::HttpClient - HTTP client connector for WWW::Kickstarter


=head1 VERSION

Version 0.9.0


=head1 SYNOPSIS

   use WWW::Kickstarter;

   my $ks = WWW::Kickstarter->new(
      http_client_class => 'WWW::Kickstarter::HttpClient::Lwp',   # default
      ...
   );


=head1 DESCRIPTION

This module documents the interface that must be provided by HTTP clients to be used by WWW::Kickstarter.


=head1 CONSTRUCTOR

   my $http_client = $http_client_class->new(%opts);

The constructor. An L<WWW::Kickstarter::Error> object is thrown on error.

Options:

=over

=item * C<< agent => "application_name/version " >>

The string to pass to Kickstarter in the User-Agent HTTP header.
If the string ends with a space, the name and version of this library will be appended,
as will the name of version of the underling HTTP client.

=back


=head1 METHODS

=head2 request

   my ( $status_code, $status_line, $content_type, $content_encoding, $content ) =
      $http_client->request($method, $url, ~~~);

~~~


=head1 VERSION, BUGS, KNOWN ISSUES, SUPPORT, AUTHORS, COPYRIGHT & LICENSE

See L<WWW::Kickstarter>


=cut
