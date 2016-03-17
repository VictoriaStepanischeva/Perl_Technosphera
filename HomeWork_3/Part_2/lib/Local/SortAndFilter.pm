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
use Data::Dumper;
sub filtration
{
    my @records = @{shift()};
    my %filters = ('band'=> shift(), 'year'=> shift(), 'album'=> shift(), 'track'=> shift(), 'format'=> shift());
    my %functions = ('band'=> sub { $filters{'band'} eq shift(); },
    'year' => sub { $filters{'year'} ==  shift(); }, 'album'=>  sub { $filters{'album'} eq shift(); }, 
    'track'=> sub { $filters{'track'} eq shift(); }, 'format'=> sub { $filters{'format'} eq shift(); });
    for my $filter (keys %filters)
    {
        if ($filters{$filter})
        {
            @records = grep { $functions{$filter}($_->{$filter}) } @records;
        }
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
