#!/usr/bin/perl
package Marla::Site;

use strict;
use warnings;

use Carp;

require Exporter;

our @ISA     = qw(Exporter);
our @EXPORT  = qw(hello_world);
our $VERSION = 1.00;

sub new {
    my $class = shift;
    my $self = {};

    # TODO Insert your constructor here

    return bless($self, $class);
}

sub hello_world {
    my $self = shift;

    print "Hello from Marla::Site!\n";
};

1;

# vim: set ts=4 sw=4 :
