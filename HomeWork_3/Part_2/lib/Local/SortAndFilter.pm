package Local::SortAndFilter;

use strict;
use warnings;
use Exporter 'import';
=encoding utf8

=head1 NAME

Local::MusicLibrary - core music library module

=head1 VERSION

Version 1.00

=cut

our $VERSION = '1.00';

=head1 SYNOPSIS

=cut

our @EXPORT = qw(sorting filtration);
sub filtration
{
    my @records = @{shift()};
    my $band = shift();
    if ($band)
    {
        @records = grep { $band eq $_->{'band'}; } @records;        
    }
    my $year = shift();
    if ($year)
    {
        @records = grep { $year ==  $_->{'year'}; } @records;
    }
    my $album = shift();
    if ($album)
    {
        @records = grep { $album eq $_->{'album'}; } @records;
    }
    my $track = shift();
    if ($track)
    {
        @records = grep { $track eq $_->{'track'}; } @records;
    }
    my $format = shift();
    if ($format)
    {
        @records = grep { $format eq $_->{'format'}; } @records;
    }
    return \@records;
}
sub sorting
{
    my @records = @{shift()};
    my $sort = shift();
    if ($sort eq 'year')
    {
        @records = sort {$a->{$sort} <=> $b->{$sort}} @records;
    }
    else
    {
        @records = sort {lc($a->{$sort}) cmp lc($b->{$sort})} @records;
    }
    return \@records;
}
1;
