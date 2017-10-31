#!/usr/bin/perl

use warnings;
use strict;

=head1 NAME

personal-github-api.pl -- simple tool for mining my personal GitHub
repo using GitHub's V3 API

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS



=cut

use Net::GitHub::V3;
use Data::Dumper;

my $oauth_token = # pull in through a slurp
my $gh = Net::GitHub::V3->new
  (
   access_token => $oauth_token,
   raw_string => 1
  );

my $repos = $gh->repos;
my @mine = $repos->list_user('jeremiah',
			     {
			      sort => 'updated'
			     });
print map { $_  } @mine;
