package Local::MusicLibrary::SortAndFilter;

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
sub num_cmp
{
    shift() == shift();
}
sub str_cmp
{
    shift() eq shift();
}
sub filtration
{
    my $records = shift();
    my @records = @{$records};
    my %filters;
    @filters{qw(band year album track format)} = @_;
    for my $filter (keys %filters)
    {
        next unless defined $filters{$filter};
        if ($filter eq 'year')
        {
            @records = grep { num_cmp($filters{$filter}, $_->{$filter}); } @records;
        }
        else
        {
            @records = grep { str_cmp($filters{$filter}, $_->{$filter}); } @records;
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
