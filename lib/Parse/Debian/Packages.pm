use strict;
package Parse::Debian::Packages;
our $VERSION = '0.01';

sub new {
    my $class = shift;
    my $fh = shift;

    return bless { fh => $fh }, $class;
}

sub next {
    my $self = shift;
    my $fh   = $self->{fh};

    my %parsed;
    while (<$fh>) {
        last if /^$/;
        if (my ($key, $value) = m/^(.*): (.*)/) {
            $parsed{$key} = $value;
        }
        else {
            s/ //;
            s/^\.$//;
            $parsed{body} .= $_;
        }
    }

    return %parsed;
}

1;
