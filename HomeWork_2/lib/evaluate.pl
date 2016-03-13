=head1 DESCRIPTION

Эта функция должна принять на вход ссылку на массив, который представляет из себя обратную польскую нотацию,
а на выходе вернуть вычисленное выражение

=cut

use 5.010;
use strict;
use warnings;
use diagnostics;
BEGIN{
	if ($] < 5.018) {
		package experimental;
		use warnings::register;
	}
}
no warnings 'experimental';

sub is_binary
{
    my $oper = shift;
    return 1 if ($oper eq '+' or $oper eq '-' or $oper eq '*' or $oper eq '/' or $oper eq '^');
    return 0;
}

sub is_unary
{
    my $oper = shift;
    return 1 if ($oper eq 'U+' or $oper eq 'U-');
    return 0;
}

sub evaluate
{
    my $rpn = shift;
    my @rpn = @{$rpn};
    my @stack;
    while (@rpn > 0)
    {
        my $current = shift(@rpn);
        if (is_binary($current))
        {
            my $right = pop(@stack);
            my $left = pop(@stack);
            if ($current eq '^')
            {
                push(@stack, eval $left.'**'.$right);
            }
            else
            {
                push(@stack, eval $left.$current.$right);
            }
        }
        elsif (is_unary($current))
        {
            $current =~ s/U//;
            push(@stack, eval $current.' '.pop(@stack));
        }
        else
        {
            push(@stack, 0 + $current);
        }
    }
    return pop(@stack);
}

1;
