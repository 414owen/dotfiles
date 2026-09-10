#!/usr/bin/env perl
use strict;
use warnings;

# Check argument
my $dir = shift @ARGV // '';
die "Usage: $0 <up|down>\n" unless $dir =~ /^(up|down)$/;

# Current and maximum raw brightness.
my $current = `brightnessctl get`;
chomp $current;
my $max = `brightnessctl max`;
chomp $max;
die "Could not read brightness from brightnessctl\n"
    unless $current =~ /^\d+$/ && $max =~ /^\d+$/ && $max > 0;

# 5% steps normally, 1% steps when dim so the low end stays adjustable.
my $coarse = int($max * 5 / 100) || 1;
my $fine   = int($max * 1 / 100) || 1;
my $low    = int($max * 10 / 100);    # switch to fine steps below 10%
my $min    = $coarse;                 # lowest backlight we bother with

# This panel uses a non-linear scale, so actual_brightness never reaches 0:
# raw 0 still leaves it lit. The only way to really turn the screen off is
# DPMS via sway, so hitting the bottom powers the outputs down instead.
if ($dir eq 'up') {
    # Bring the displays back first (a no-op when they are already on).
    system('swaymsg', 'output', '*', 'power', 'on');

    my $target = $current < $low ? $current + $fine : $current + $coarse;
    $target = $min if $target < $min;
    $target = $max if $target > $max;

    system('brightnessctl', '--quiet', 'set', $target) == 0
        or die "Failed to set brightness to $target\n";
} else {
    if ($current <= $min) {
        # At the bottom: turn the output(s) off.
        system('swaymsg', 'output', '*', 'power', 'off');
    } else {
        my $step   = $current < $low ? $fine : $coarse;
        my $target = $current - $step;
        $target = $min if $target < $min;

        system('brightnessctl', '--quiet', 'set', $target) == 0
            or die "Failed to set brightness to $target\n";
    }
}
