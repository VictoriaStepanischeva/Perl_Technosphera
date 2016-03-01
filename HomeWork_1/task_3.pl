use 5.010;
use strict;
use warnings;
use Data::Dumper;
use DDP;
my @a;
while (<>)
{
    chomp;
    push @a, [split (/:/)];
}
print "Data::Dumper\n", Dumper \@a;
print "DDP\n";
p @a;
