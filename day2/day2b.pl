#!/usr/bin/perl -w
use strict;

use List::Util qw(all min max);
use List::MoreUtils qw(pairwise);

my $num_safe = 0;

while (<>) {
    my $line = $_;
    chomp($line);
    $line =~ s/^\s*//; $line =~ s/\s*$//;
    my @elts = split(/\s+/, $line);
    #if (is_safe($., $_)) { print "Line $. is safe\n"; $num_safe++; }
    if (is_safe($., @elts)) { $num_safe++; }
}

print "num safe == $num_safe\n";
exit(0);

sub is_safe {
    my ($line_num, @elts) = @_;

    if (_is_safe($line_num, @elts)) {
        return 1;
    }
    # Try removing a level and running _is_safe() - return true if _is_safe() is true, or false if all of them are false
    my $num_elts = scalar(@elts); 

    foreach my $trial (0..$num_elts -1) {
        my @elts_mod = @elts;
        splice(@elts_mod, $trial, 1);
        if (_is_safe($line_num, @elts_mod)) {
            return 1;
        }
    }
    return 0;

}

sub _is_safe {
    my ($line_num, @elts) = @_;

    my $prev = undef;
    my @deltas = ();

    foreach my $elt (@elts) {
        if (! defined $prev) { $prev = $elt; next; }

        my $delta = $elt - $prev;
        if ($delta == 0 or abs($delta) > 3) { return 0; }

        push @deltas, $delta;
        $prev = $elt;
    }
    my $delta_str = join(" ", @deltas);
    my $elt_str = join(" ", @elts);

    #print "Line: $line_num Deltas: $delta_str elts: $elt_str\n";

    my $min = min @deltas;
    my $max = max @deltas;

    if (same_sign($min, $max)) {
        return 1;
    }
    return 0;
}

sub same_sign {
    my ($a, $b) = @_;
    if ($a > 0 && $b > 0) {
        return 1;
    }
    if ($a < 0 && $b < 0) {
        return 1;
    }
    return 0;
}


__END__
--- Day 2: Red-Nosed Reports ---

The engineers are surprised by the low number of safe reports until they realize they forgot to tell you about the Problem Dampener.

The Problem Dampener is a reactor-mounted module that lets the reactor safety systems tolerate a single bad level in what would otherwise be a safe report. It's like the bad level never happened!

Now, the same rules apply as before, except if removing a single level from an unsafe report would make it safe, the report instead counts as safe.

More of the above example's reports are now safe:

7 6 4 2 1: Safe without removing any level.
1 2 7 8 9: Unsafe regardless of which level is removed.
9 7 6 2 1: Unsafe regardless of which level is removed.
1 3 2 4 5: Safe by removing the second level, 3.
8 6 4 4 1: Safe by removing the third level, 4.
1 3 6 7 9: Safe without removing any level.
Thanks to the Problem Dampener, 4 reports are actually safe!

Update your analysis by handling situations where the Problem Dampener can remove a single level from unsafe reports. How many reports are now safe?

