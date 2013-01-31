#!/usr/bin/perl
package Marla::Site;

use strict;
use warnings;

use Carp;

require Exporter;

our @ISA     = qw(Exporter);
our @EXPORT  = qw();
our @VERSION = 1.00;

sub new {
    my $class = shift;
    my $self = {
        routes => [],
        views => {},
        models => {},
        config => {}
    };

    return bless($self, $class);
}

sub serve {
    my $self = shift;
    my $request = shift;

    my $best_route_score = 0;
    my $best_route;

    foreach my $route_pred (@{$self->{routes}}) {
        my ($route, $route_score) = $route_pred->($request);

        next if not defined $route;

        if (not defined $route_score or $route_score > $best_route_score) {
            $best_route_score = $route_score;
            $best_route = $route;
        }
        # Short-circuit for routes without scores
        last if not defined $route_score;
    }

    $best_route->($self) if $best_route or croak "Unhandled request: $request";
}

sub get_view {
    my $self = shift;

    my $name = shift;
    my $view = $self->{views}->{$name} or croak "No view found for name: '$name'";
    return $view;
}

sub set_view {
    my $self = shift;

    my $name = shift;
    $self->{views}->{$name} = shift;
}

sub get_model {
    my $self = shift;

    my $name = shift;
    my $model = $self->{models}->{$name} or croak "No model found for name: '$name'";
    return $model;
}

sub set_model {
    my $self = shift;

    my $name = shift;
    $self->{models}->{$name} = shift;
}

sub get_config {
    my $self = shift;

    my $name = shift;
    return $self->{config}->{$name};
}

sub set_config {
    my $self = shift;

    my $name = shift;
    $self->{config}->{$name} = shift;
}

sub add_route {
    my $self = shift;

    push $self->{routes}, shift;
}

1;

# vim: set ts=4 sw=4 :
