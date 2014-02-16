
package WWW::Kickstarter::Data::Project;

use strict;
use warnings;
no autovivification;


use WWW::Kickstarter::Data       qw( );
use WWW::Kickstarter::Data::User qw( );


our @ISA = 'WWW::Kickstarter::Data';


sub _new {
   my_croak(400, "Incorrect usage") if @_ < 3;
   my ($class, $ks, $data, %opts) = @_;

   if (my @unrecognized = keys(%opts)) {
      my_croak(400, "Unrecognized parameters @unrecognized");
   }

   my $self = $class->SUPER::_new($ks, $data);
   $self->{creator} = WWW::Kickstarter::Data::User->_new($ks, $self->{creator}) if exists($self->{creator});

   return $self;
}


sub id            { $_[0]{id} }
sub slug          { $_[0]{slug} }
sub name          { $_[0]{name} }
sub url           { $_[0]{urls}{web}{project} }
sub blurb         { $_[0]{blurb} }
sub launched_at   { $_[0]{launched_at} }    # When project started
sub deadline      { $_[0]{deadline} }       # When project ends
sub backers_count { $_[0]{backers_count} }
sub goal          { $_[0]{goal} }
sub pledged       { $_[0]{pledged} }
sub creator       { $_[0]{creator} }

sub category_id   { $_[0]{category}{id} }
sub category_name { $_[0]{category}{name} }

sub progress      { $_[0]{pledged} / $_[0]{goal} }
sub progress_pct  { sprintf "%.0f", $_[0]{pledged} / $_[0]{goal} * 100 }


sub refetch { my $self = shift;  return $self->ks->project($self->id, @_); }


1;


__END__

=head1 NAME

WWW::Kickstarter::Data::Project - Kickstarter project data


=head1 SYNOPSIS

   use WWW::Kickstarter;

   my $email    = '...';  # Your Kickstarter login credentials
   my $password = '...';

   my $ks = WWW::Kickstarter->new();
   $ks->login($email, $password);

   my $iter = $ks->projects_ending_soon();
   while (my ($project) = $iter->()) {
      print($project->name, "\n");
   }


=head1 ACCESSORS

=head2 id

   my $project_id = $project->id;

Returns the numerical id of the project.


=head2 slug

   my $project_slug = $project->slug;

Returns creator-selected keyword id of the project, or undef if it doesn't have one.


=head2 name

   my $project_name = $project->name;

Returns the project's name.


=head2 url

   my $project_url = $project->url;

Returns the web address of the project's main page.


=head2 blurb

   my $project_blurb = $project->blurb;

Returns a short plain-text description of the project.


=head2 launched_at

   my $project_launched_at = $project->launched_at;

Returns the epoch timestamp (as returned by L<C<time>|perlfunc/time>) of the project's launch.


=head2 deadline

   my $project_deadline = $project->deadline;

Returns the epoch timestamp (as returned by L<C<time>|perlfunc/time>) of the project's deadline.


=head2 backers_count

   my $project_backers_count = $project->backers_count;

Returns the number of backers the project has.


=head2 goal

   my $project_goal = $project->goal;

Returns the amount of USD the project is attempting to raise.


=head2 pledged

   my $project_pledged = $project->pledged;

Returns the amount of USD that has been pledged to the project.


=head2 creator

   my $user = $project->creator;

Returns the creator of the project as an L<WWW::Kickstarter::Data::User> object.

Some data will not available without a refetch.


=head2 category_id

   my $project_category_id = $project->category_id;

Returns the id of the category of the project.


=head2 category_name

   my $project_category_name = $project->category_name;

Returns the name of the category of the project.


=head2 progress

   my $project_progress = $project->progress;

Returns the progress towards the project's goal. For example, a value greater than or equal to 1.00 indicates the goal was reached.


=head2 progress_pct

   my $project_progress_pct = $project->progress_pct;

Returns the progress towards the project's goal as a percent. For example, a value greater than or equal to 100 indicates the goal was reached


=head1 API CALLS

=head2 refetch

   $project = $project->refetch();

Refetches this project from Kickstarter.


=head1 VERSION, BUGS, KNOWN ISSUES, SUPPORT, AUTHORS, COPYRIGHT & LICENSE

See L<WWW::Kickstarter>


=cut
