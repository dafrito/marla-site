#!/usr/bin/perl
package Marla::Response;

use strict;
use warnings;

use Carp;

use Exporter;

our @ISA     = qw(Exporter);
our @EXPORT  = qw(response_200 response_404);
our $VERSION = 1.00;

sub response_404 {
    my $request = shift;
    my $path = shift;

    $path ||= $request->path_info;

    return sub {
        print "HTTP/1.1 404 Not found\r\n";
        print $request->header;
        print "File not found: $path";
    };
}

sub response_200 {
    my $request = shift;
    my $content_builder = shift;

    return sub {
        my ($output, $media_type) = $content_builder->(@_);

        print "HTTP/1.1 200 OK\r\n";
        print $request->header($media_type);
        print $output;
    };
}

1;

# vim: set ts=4 sw=4 :
