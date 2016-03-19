package Local::MusicLibrary;

use strict;
use warnings;
use Exporter 'import';
use List::Util 'max';
use Local::MusicLibrary::GetRecords;
use Local::MusicLibrary::SortAndFilter;
use Local::MusicLibrary::Printing;
=encoding utf8

=head1 NAME

Local::MusicLibrary - core music library module

=head1 VERSION

Version 1.00

=cut

our $VERSION = '1.00';

=head1 SYNOPSIS

=cut

our @EXPORT = qw(main);
sub main
{
    my @input = @{shift()};
    my $band = shift();
    my $year = shift();
    my $album = shift();
    my $track = shift();
    my $format = shift();
    my $sort = shift();
    my $columns = shift();
    my $records = get_records(@input);
    $records = filtration($records, $band, $year, $album, $track, $format);
    if ($sort)
    {
        $records = sorting($records, $sort);
    }
    return printing($records, $columns);
}
1;
