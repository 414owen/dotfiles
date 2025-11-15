#!/usr/bin/env perl
use strict;
use warnings;

# Check argument
my $dir = shift @ARGV or die "Usage: $0 <up|down>\n";
die "Argument must be 'up' or 'down'.\n" unless $dir =~ /^(up|down)$/;

# Get current brightness (raw) and max
my $current = `brightnessctl g`;
chomp($current);
my $max = `brightnessctl m`;
chomp($max);

# Convert to integer percent
my $percent = int($current * 100 / $max);

# Determine amount to change
my ($abs, $pct);

if ($percent < 7) {
    $abs = 1;      # absolute amount
    $pct = undef;
} else {
    $pct = 5;      # percent change
    $abs = undef;
}

# Construct brightnessctl command
my $cmd;

if ($dir eq 'up') {
    if (defined $abs) {
        $cmd = "brightnessctl set +$abs";
    } else {
        $cmd = "brightnessctl set +$pct%";
    }
} else {  # down
    if (defined $abs) {
        $cmd = "brightnessctl set $abs-";
    } else {
        $cmd = "brightnessctl set $pct%-";
    }
}

# Execute
system($cmd) == 0 or die "Failed to run $cmd\n";

