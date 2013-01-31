#!/usr/bin/perl
package Marla::View;

use strict;
use warnings;

use Carp;

require Exporter;

our @ISA     = qw(Exporter);
our @EXPORT  = qw();
our @VERSION = 1.00;

sub cat {
    my $file = shift or croak "No file specified";

    local($/);
    open(my $fh, $file) or croak "Failed to serve static file: $file ($!)";
    my $output = <$fh>;
    close($fh);

    return $output;
}

1;

# vim: set ts=4 sw=4 :
