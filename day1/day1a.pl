#!/apps/perl/5.14.2/bin/perl
use strict;
use lib "/apps/perl/modules-1608/lib";

use List::Util qw(zip);

my @a = ();
my @b = ();

while (<>) {
    if (/^\s*(\d+)\s+(\d+)\s*$/) {
        push @a, $1;
        push @b, $2;
    }
}

my @zip = zip \@a, \@b;

my $total_diff = 0;

foreach my $pair (@zip) {
    my $diff = abs($pair->[0] - $pair->[1]);
    $total_diff += $diff;
}

print "$total_diff\n";
exit(0);


