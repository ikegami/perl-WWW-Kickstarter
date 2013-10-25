
package WWW::Kickstarter;

use strict;
use warnings;

use version; our $VERSION = qv('v0.9.0');

use LWP::Protocol::https qw( );
use LWP::UserAgent       qw( );

# ~~~

1;


__END__

=head1 NAME

WWW::Kickstarter - Retrieve information from Kickstarter


=head1 VERSION

Version 0.9.0


=head1 SYNOPSIS

    use WWW::Kickstarter;

    ~~~


=head1 DESCRIPTION

~~~


=head1 BUGS

Please report any bugs or feature requests to C<bug-WWW-Kickstarter at rt.cpan.org>,
or through the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-Kickstarter>.
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WWW::Kickstarter

You can also look for information at:

=over 4

=item * Search CPAN

L<http://search.cpan.org/dist/WWW-Kickstarter>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-Kickstarter>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WWW-Kickstarter>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WWW-Kickstarter>

=back


=head1 AUTHORS

Eric Brine, C<< <ikegami@adaelis.com> >>

Initial release based on Mark Olson's "Kickscraper" project for Ruby.


=head1 COPYRIGHT & LICENSE

No rights reserved.

The author has dedicated the work to the Commons by waiving all of his
or her rights to the work worldwide under copyright law and all related or
neighboring legal rights he or she had in the work, to the extent allowable by
law.

Works under CC0 do not require attribution. When citing the work, you should
not imply endorsement by the author.


=cut
