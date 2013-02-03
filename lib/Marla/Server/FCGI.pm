#!/usr/bin/perl
package Marla::Server::FCGI;

use strict;
use warnings;

use Carp;
use CGI::Fast;

require Exporter;

our @ISA     = qw(Exporter);
our @EXPORT  = qw(hello_world);
our $VERSION = 1.00;

sub set_site {
    my $self = shift;
    $self->{_site} = shift;
}

sub get_site {
    my $self = shift;
    return $self->{_site};
}

sub run {
    my $self = shift;

    while (my $q = new CGI::Fast) {
        $self->get_site()->server($q);
    }
};

1;

# vim: set ts=4 sw=4 :
