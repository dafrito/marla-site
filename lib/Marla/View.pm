#!/usr/bin/perl
package Marla::View;

use strict;
use warnings;

use Carp;

require Exporter;

our @ISA     = qw(Exporter);
our @EXPORT  = qw(view_cat view_tt);
our $VERSION = 1.00;

sub view_cat {
    my $path = shift;

    -d $path or die "Path does not exist or is not a directory: $path";

    return sub {
        my $file = shift or croak "No file specified";

        local($/);
        open(my $fh, "$path/$file") or croak "Failed to serve static file: $path/$file ($!)";
        my $output = <$fh>;
        close($fh);

        return $output;
    }
}

sub view_tt {
    my $site = shift;
    my $template_name = shift;

    return sub {
        my $output = "";

        my $tt = $site->get_config("tt");

        my $content = shift;
        $tt->process($template_name, $content, \$output) or die($tt->error);

        return $output;
    };
}

1;

# vim: set ts=4 sw=4 :
