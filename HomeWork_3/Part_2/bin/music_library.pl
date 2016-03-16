#!/usr/bin/env perl

use strict;
use warnings;
use Getopt::Long;
BEGIN {push(@INC, '/home/victoria/Perl_Technosphera/HomeWork_3/Part_2/lib');}
use Local::MusicLibrary;
my $band;
my $year;
my $album;
my $track;
my $format;
my $sort;
my @columns;
Getopt::Long::GetOptions(
    'band=s' => \$band,
    'year=i' => \$year,
    'album=s' => \$album,
    'track=s' => \$track,
    'format=s' => \$format,
    'sort=s' => \$sort,
    'columns=s{1,}' => \@columns);
if (!@columns)
{
    @columns = ('band', 'year', 'album', 'track', 'format');
}
my @input;
while (<>)
{
    push(@input, $_);
}
print main(\@input, $band, $year, $album, $track, $format, $sort, \@columns),"\n";
