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


=head1 NAME

Parse::Debian::Packages - parse the data from a debian Packages.gz

=head1 SYNOPSIS

 use YAML;
 use IO::File;
 use Parse::Debian::Packages;
 my $fh = IO::File->new("Packages");

 my $parser = Parse::Debian::Packages->new( $fh );
 while (my %package = $parser->next) {
     print Dump \%package;
 }

=head1 DESCRIPTION

This module parses the Packages files used by the debian package
management tools.

It presents itself as an iterator.  Each call of the ->next method
will return the next package found in the file.

For laziness, we take a filehandle in to the constructor.  Please open
the file for us.

=head1 AUTHOR

Richard Clamp <richardc@unixbeard.net>

=head1 COPYRIGHT

Copyright (C) 2003 Richard Clamp.  All Rights Reserved.

This module is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 SEE ALSO

Module::Packaged

=cut

