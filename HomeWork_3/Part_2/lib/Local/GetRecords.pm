package Local::GetRecords;

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

our @EXPORT = qw(get_records);
sub get_records
{
    my @records;        
    for my $record(@_)
    {
        $record =~ m{^\./(.*)/(.*) - (.*)/(.*)\.(.*)$};
        push(@records, {band => $1, year => $2, album => $3, track => $4, format => $5});
    }
    return \@records;
}
1;
