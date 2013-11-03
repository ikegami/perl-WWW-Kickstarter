
package WWW::Kickstarter::Category;

use strict;
use warnings;
no autovivification;


use WWW::Kickstarter::Error  qw( my_croak );
use WWW::Kickstarter::Object qw( );


our @ISA = 'WWW::Kickstarter::Object';


sub new {
   my ($class, $ks, $data, %opts) = @_;
   my_croak(400, "Incorrect usage") if @_ < 3;

   if (my @unrecognized = keys(%opts)) {
      my_croak(400, "Unrecognized parameters @unrecognized");
   }

   my $self = $class->SUPER::new($ks, $data);
   $self->{_}{subcategories} = undef;

   return $self;
}


sub _set_subcategories { my $self = shift; $self->{_}{subcategories} = [ @_ ]; }


sub id   { $_[0]{id} }
sub slug { $_[0]{slug} }
sub name { $_[0]{name} }


sub subcategories {
   my ($self) = @_;
   my $subcategories = $self->{_}{subcategories}
      or my_croak(400, "The list of subcategories is only avaiable for Category objects created by \$ks->categories()");

   return @$subcategories;
}


sub projects             { my $self = shift;  return $self->ks->category_projects($self->id, @_); }
sub projects_recommended { my $self = shift;  return $self->ks->category_projects_recommended($self->id, @_); }


1;


__END__

=head1 NAME

WWW::Kickstarter::Category - Kickstarter category data


=head1 SYNOPSIS

   use WWW::Kickstarter;

   ~~~


=head1 API CALLS

=head2 projects

   my $projects_iter = $category->projects(%opts);

Returns an L<iterator|WWW::Kickstarter::Iterator> that fetches and returns projects in the specified category as L<WWW::Kickstarter::Project> objects.

The argument may be the category's numerical id (as returned by C<< $category->id >>), its "slug" (as returned by C<< $category->slug >>) or its name (as returned by C<< $category->name >>).

It accepts the same options as WWW::Kickstarter's C<L<WWW::Kickstarter/projects>>.


=head2 projects_recommended

   my $projects_iter = $category->projects_recommended(%opts);

Returns an L<iterator|WWW::Kickstarter::Iterator> that fetches and returns the recommended projects in the specified category as L<WWW::Kickstarter::Project> objects.

The argument may be the category's numerical id (as returned by C<< $category->id >>), its "slug" (as returned by C<< $category->slug >>) or its name (as returned by C<< $category->name >>).

It accepts the same options as WWW::Kickstarter's C<L<WWW::Kickstarter/projects>>.


=head1 ACCESSORS

=head2 id

   my $category_id = $category->id;

Returns the numerical category id of the category.


=head2 name

   my $category_name = $category->name;

Returns the category's name.


=head2 subcategories

   my @categories = $category->subcategories;

~~~


=head1 VERSION, BUGS, KNOWN ISSUES, SUPPORT, AUTHORS, COPYRIGHT & LICENSE

See L<WWW::Kickstarter>


=cut
