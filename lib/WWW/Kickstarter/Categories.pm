
package WWW::Kickstarter::Categories;

use strict;
use warnings;
no autovivification;


use WWW::Kickstarter::Error qw( my_croak );


our @ISA = 'WWW::Kickstarter::Object';


sub new {
   my ($class, $ks, $categories, %opts) = @_;
   my_croak(400, "Incorrect usage") if @_ < 3;

   if (my @unrecognized = keys(%opts)) {
      my_croak(400, "Unrecognized parameters @unrecognized");
   }

   my @tree;
   for my $category (@$categories) {
      my $parent_info = $category->{parent};
      my $parent_id   = $parent_info ? $parent_info->{id} : 0;
      my $position    = $category->{position};
      $tree[$parent_id][$position] = $category;
   }

   for my $category (@$categories) {
      my $subcategories = $tree[ $category->{id} ];
      $category->_set_subcategories( $subcategories ? grep defined, @$subcategories : () );
   }

   my $data = {
      categories => $categories,
      top_level  => [ grep defined, @{ $tree[0] } ],
   };

   return $class->SUPER::new($ks, $data);
}


sub categories           { @{ $_[0]{categories} } }
sub top_level_categories { @{ $_[0]{top_level} } }


sub refetch { my $self = shift;  return $self->ks->categories(@_); }


sub _visit {
   my $self     = shift;
   my $visitor  = shift;
   my $category = shift;
   my $depth    = shift;

   my @subcategories =
      sort { $a->name() cmp $b->name() }
         $category ? $category->subcategories() : @{ $self->{top_level} };

   my $visit_next = sub {
      return 0 if !@subcategories;
      $self->_visit($visitor, shift(@subcategories), $depth+1, @_);
      return 1;
   };

   $visitor->($category, $depth, $visit_next, 0+@subcategories, @_);
}


sub visit {
   my_croak(400, "Incorrect usage") if @_ < 2;
   my $self = shift;
   my $opts = shift;

   my $visitor;
   if (ref($opts) eq 'CODE') {
      $visitor = $opts;
      $opts = undef;
   } else {
      $visitor = $opts->{visitor};
   }
   
   if ($opts->{root}) {
      $self->_visit($visitor, undef, 0, @_);
   } else {
      for my $category (
         sort { $a->name() cmp $b->name() }
            @{ $self->{top_level} }
      ) {
         $self->_visit($visitor, $category, 0, @_);
      }
   }
}


1;


__END__

=head1 NAME

WWW::Kickstarter::Categories - Kickstarter categories


=head1 SYNOPSIS

   use WWW::Kickstarter;

   ~~~


=head1 DESCRIPTION

~~~


=head1 API CALLS

=head2 refetch

   $categories = $categories->refetch();

Refetches the categories from Kickstarter.


=head1 METHODS

=head2 visit

   sub visitor {
      my ($category, $depth, $visit_next, $num_subcategories, @args) = @_;
      ...
   }

   $categories->visit(\&visitor, @args);

   $categories->visit({ visitor => \&visitor, %opts }, @args);

Traverses the category hiearchy in a depth-first, alphabetical manner.

~~~

Options:

=over

=item * C<< root => 1 >>

~~~


=back


=head3 Examples

=over

=item * Simple Example

   $categories->visit(sub{
      my ($category, $depth, $visit_next) = @_;
      say "   " x $depth, $category->name;
      1 while $visit_next->();
   });

Output:

   Art
      Crafts
      Digital Art
      ...
      Sculpture
   Comics
   Dance
   Design
      Graphic Design
      Product Design
   ...

=item * Passing data down.

   $categories->visit(sub{
      my ($category, $depth, $visit_next, undef, $parent) = @_;
      say $parent . $category->name;
      1 while $visit_next->($parent . $category->name . '/');
   }, '');

Output:

   Art
   Art/Crafts
   Art/Digital Art
   ...
   Art/Sculpture
   Comics
   Dance
   Design
   Design/Graphic Design
   Design/Product Design
   ...


=item * ~~~

   $categories->visit({
      root    => 1,
      visitor => sub{
         my ($category, $depth, $visit_next, $num_subcategories, $subcategory_idx) = @_;
   
         if ($category) {
            my $class = $subcategory_idx % 2 ? 'odd' : 'even';
            print qq{<li class="$class">} . $category->name;
         }
   
         if ($num_subcategories) {
            say "<ul>";
            for my $subcategory_idx (1..$num_subcategories) {
               $visit_next->($subcategory_idx);
            }
            say "</ul>";
         }
   
         if ($category) {
            say "</li>"
         }
      },
   });

Output:

   <ul>
   <li class="odd">Art<ul>
   <li class="odd">Crafts</li>
   <li class="even">Digital Art</li>
   ...
   <li class="even">Sculpture</li>
   </ul>
   </li>
   <li class="even">Comics</li>
   <li class="odd">Dance</li>
   <li class="even">Design<ul>
   <li class="odd">Graphic Design</li>
   <li class="even">Product Design</li>
   </ul>
   </li>
   ...
   </ul>


=head1 ACCESSORS

=head2 C<< my @categories = $categories->categories; >>

Returns a L<WWW::Kickstarter::Category> object for each Kickstarter category.


=head2 C<< my @categories = $categories->top_level_categories; >>

Returns a L<WWW::Kickstarter::Category> object for each top-level Kickstarter category.


=head1 VERSION, BUGS, KNOWN ISSUES, SUPPORT, AUTHORS, COPYRIGHT & LICENSE

See L<WWW::Kickstarter>


=cut
