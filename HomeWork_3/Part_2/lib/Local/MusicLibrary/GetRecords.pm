package Local::MusicLibrary::GetRecords;

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
    for my $record (@_)
    {
        $record =~ m{^\./(?<band>[^/]+)/(?<year>\d+)\s+-\s+(?<album>[^/]+)/(?<track>.+)\.(?<format>.+)$};
        push(@records, {%+});
    }
    return \@records;
}
1;
