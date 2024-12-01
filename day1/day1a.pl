#!/usr/bin/perl -w
use strict;

use List::MoreUtils qw(pairwise);

my @a = ();
my @b = ();

while (<>) {
    if (/^\s*(\d+)\s+(\d+)\s*$/) {
        push @a, $1;
        push @b, $2;
    }
}

@a = sort(@a);
@b = sort(@b);

my @diffs = pairwise { abs($a - $b) } @a, @b;

my $total_diff = 0;

foreach my $diff (@diffs) {
    $total_diff += $diff;
}

print "$total_diff\n";
exit(0);


