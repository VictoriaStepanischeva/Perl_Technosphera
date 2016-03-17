package Local::Printing;

use strict;
use warnings;
use Exporter 'import';
use List::Util 'max';
=encoding utf8

=head1 NAME

Local::MusicLibrary - core music library module

=head1 VERSION

Version 1.00

=cut

our $VERSION = '1.00';

=head1 SYNOPSIS

=cut

our @EXPORT = qw(printing);
sub printing
{
    my @records = @{shift()};
    if (!@records)
    {
        return "Empty \n";
    }
    my @columns = @{shift()};
    my %len;
    my @separators;
    for my $key ('band', 'year', 'album', 'track', 'format')
    {
        $len{$key} = max map {length($_->{$key})} @records;
    }
    for my $column (@columns)
    {
        push (@separators, '-' x ($len{$column}+2));
    }
    my @result;
    push(@result, '/'.join('-', @separators).'\\');
    for my $record (@records)
    {
        my @_result = map {sprintf " %*s ", $len{$_}, $record->{$_}} @columns;
        push(@result, '|'.join('|', @_result).'|'); 
        push(@result,  '|'.join('+', @separators).'|');
    }
    $result[-1] = '\\'.join('-', @separators).'/';
    return join("\n", @result);
}
1;
