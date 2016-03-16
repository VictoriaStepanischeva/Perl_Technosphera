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
    my @columns = @{shift()};
    my %len;
    my @separators;
    $len{'band'} = max map {length($_->{'band'})} @records;
    $len{'year'} = max map {length($_->{'year'})} @records; 
    $len{'album'} = max map {length($_->{'album'})} @records;
    $len{'track'} = max map {length($_->{'track'})} @records;
    $len{'format'} = max map {length($_->{'format'})} @records;
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
