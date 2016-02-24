package Lingua::ID::Number::Format::MixWithWords;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use Lingua::Base::Number::Format::MixWithWords;
use parent qw(Lingua::Base::Number::Format::MixWithWords);
require Lingua::EN::Number::Format::MixWithWords;

use Math::Round qw(nearest);
use Number::Format;
use POSIX qw(floor log10);
use Perinci::Sub::Util qw(gen_modified_sub);

use Exporter;
our @EXPORT_OK = qw(format_number_mix);

our %SPEC;

gen_modified_sub(
    output_name => 'format_number_mix',
    summary => 'Format number to a mixture of numbers and words (e.g. "12,3 juta")',
    base_name => 'Lingua::EN::Number::Format::MixWithWords::format_number_mix',
    remove_args => ['scale'],
    output_code => sub {
        my %args = @_;

        my $f = __PACKAGE__->new(
            num_decimal   => $args{num_decimal},
            min_format    => $args{min_format},
            min_fraction  => $args{min_fraction},
        );
        $f->_format($args{num});
    }
);

my $id_names = {
    #2   => 'ratus',
    3   => 'ribu',
    6   => 'juta',
    9   => 'miliar',
    12   => 'triliun',
    15   => 'kuadriliun',
    18   => 'kuintiliun',
    21   => 'sekstiliun',
    24   => 'septiliun',
    27   => 'oktiliun',
    30   => 'noniliun',
    33   => 'desiliun',
    36   => 'undesiliun',
    39   => 'duodesiliun',
    42   => 'tredesiliun',
    45   => 'kuatuordesiliun',
    48   => 'kuindesiliun',
    51   => 'seksdesiliun',
    54   => 'septendesiliun',
    57   => 'oktodesiliun',
    60   => 'novemdesiliun',
    63   => 'vigintiliun',
    100  => 'googol',
    303  => 'sentiliun',
};

sub new {
    my ($class, %args) = @_;
    $args{decimal_point} //= ",";
    $args{thousands_sep} //= ".";
    $args{names}         //= $id_names;

    # XXX should use "SUPER"
    my $self = Lingua::Base::Number::Format::MixWithWords->new(%args);
    bless $self, $class;
}

1;
# ABSTRACT:

=head1 SYNOPSIS

 use Lingua::ID::Number::Format::MixWithWords qw(format_number_mix);

 print format_number_mix(num => 1.23e7); # prints "12,3 juta"


=head1 DESCRIPTION

This module formats number with Indonesian names of large numbers (ribu, juta,
miliar, triliun, and so on), e.g. 1.23e7 becomes "12,3 juta". If number is too
small or too large so it does not have any appropriate names, it will be
formatted like a normal number.


=head1 SEE ALSO

L<Lingua::ID::Nums2Words>

L<Lingua::EN::Number::Format::MixWithWords>

L<Number::Format>

=cut
