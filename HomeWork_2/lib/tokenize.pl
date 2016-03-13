=head1 DESCRIPTION

Эта функция должна принять на вход арифметическое выражение,
а на выходе дать ссылку на массив, состоящий из отдельных токенов.
Токен - это отдельная логическая часть выражения: число, скобка или арифметическая операция
В случае ошибки в выражении функция должна вызывать die с сообщением об ошибке

Знаки '-' и '+' в первой позиции, или после другой арифметической операции стоит воспринимать
как унарные и можно записывать как "U-" и "U+"

Стоит заметить, что после унарного оператора нельзя использовать бинарные операторы
Например последовательность 1 + - / 2 невалидна. Бинарный оператор / идёт после использования унарного "-"

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

sub tokenize {
	chomp(my $expr = shift);
    $expr =~ s/e\+/eplus/g;
    $expr =~ s/e\-/eminus/g;
	my @res = split m!([-+/*^()])!, $expr;
    my $prevtok = '';
    my $is_valid = 0;
    my $is_valid_bracket = 0;
    for (@res)
    {
        if ($prevtok =~ /^\s*$/ and $_ =~ /([-+])/)
        {
            $_ = 'U'.$1;
        }
        elsif ($_ =~ m![-+/*^]!)
        {
            $is_valid--;
        }
        elsif ($_ eq '(')
        {
            $is_valid_bracket++;
        }
        elsif ($_ eq ')')
        {
            $is_valid_bracket--;
        }
        elsif ($_ =~ /^\s*$/)
        {
            next;
        }
        elsif ($_ =~ /^\s*(\d*\.?\d*(e|eplus|eminus)?\d+)\s*$/)
        {
            $is_valid++;
            $_ =~ s/eplus/e+/g;
            $_ =~ s/eminus/e-/g;
            $_ += 0;
        }
        else
        {
            die "Error";
        }
    }
    continue
    {
        die "Error" if $is_valid_bracket < 0;
        $prevtok = $_;
    }
    die "Error" if $is_valid != 1 or $is_valid_bracket != 0;
    @res = grep(!/^\s*$/, @res);
	return \@res;
}

1;
