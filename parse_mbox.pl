#!/usr/bin/perl

# wut?

# TODO
# pull out mailboxes to allow for passing a single mailbox as an argument

use warnings;
use strict;
use Mail::Box::Manager;
use Time::Piece;
use Time::Seconds;

# our mailing lists
my @mboxen =
  qw/
      genivi-projects-2016-1H
    /;

my $mgr = Mail::Box::Manager->new;
my $T = localtime;

print  " Year | Avg. | Email | patches | list\n";
foreach my $box (@mboxen) {
  $box .= ".list.mbox";

  my $folder = $mgr->open($box);
  my $emails = $folder->messages;
  my $patches = 0;

  # Convert date to something 'sortable'
  my $first = $folder->message(-1)->get('Date');
  $first =~ s/(-|\+)(\d+)$//g; # get rid of timezone
  my $t = Time::Piece->strptime($first);
  my $s = $T - $t;
  my $per_y = $emails / $s->weeks;
  foreach my $message ($folder->messages) {

    if ($message->get('Subject') =~ /PATCH/)  {
      # If you want the date . . .
      # $message->get('Date'), "\n";
      # print $message->get('Subject'), "\n";
      # Right now we just want the number of submitted patches
      $patches++;

      # How about getting email addresses?
    }
  }

  printf(" %d  %.2f\t %d\t %d\t%s\n", $t->year, $per_y, $emails, $patches, $folder);

  $folder->close;
}

1;
