package Local::GetterSetter;

use strict;
use warnings;

=encoding utf8

=head1 NAME

Local::GetterSetter - getters/setters generator

=head1 VERSION

Version 1.00

=cut

our $VERSION = '1.00';

=head1 SYNOPSIS

    package Local::SomePackage;
    use Local::GetterSetter qw(x y);

    set_x(50);
    print our $x; # 50

    our $y = 42;
    print get_y(); # 42
    set_y(11);
    print get_y(); # 11

=cut

sub import
{
    my @parent = caller();
    my ($class, @fields)=@_;
    for my $qq (@fields)
    {
        no strict 'refs';
        *{$parent[0].'::get_'.$qq} = sub { return ${$parent[0].'::'.$qq}; };
        *{$parent[0].'::set_'.$qq} = sub { ${$parent[0].'::'.$qq} = shift(); };
    }
}

1;
