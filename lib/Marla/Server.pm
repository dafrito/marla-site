#!/usr/bin/perl
package Marla::Server;

use strict;
use warnings;

use HTTP::Server::Simple::CGI;

require Exporter;

our @ISA     = qw(Exporter HTTP::Server::Simple::CGI);
our @EXPORT  = qw();
our $VERSION = 1.00;

sub set_site {
    my $self = shift;
    $self->{_site} = shift;
}

sub get_site {
    my $self = shift;
    return $self->{_site};
}

sub handle_request {
    my $self = shift;

    die "No site provided" unless $self->get_site();

    return $self->get_site()->serve(shift);
};

1;

# vim: set ts=4 sw=4 :
