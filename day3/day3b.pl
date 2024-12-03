#!/usr/bin/perl -w
use strict;

use List::Util qw(all min max);
use List::MoreUtils qw(pairwise);

my @all_instructions = ();

while (<>) {
    my @instructions = extract_instructions($_);
    push @all_instructions, @instructions;
}

my $total = eval_instructions(@all_instructions);

print "total = $total\n";
exit(0);

sub extract_instructions {
    my ($line) = @_;
    my @instructions = ($line =~ /(mul\(\d+,\d+\)|do\(\)|don't\(\))/g);
    #/mul\(\d+,\d+\)/g);
    return @instructions;
}

sub eval_instructions {
    my (@instructions) = @_;
    my $total = 0;
    my $do = 1;
    foreach my $instruction (@instructions) {
        if ($instruction =~ /don't/) {
            $do = 0;
        }
        elsif ($instruction =~ /do\(\)/) {
            $do = 1;
        }
        else {
            if ($do) {
                my $curr = eval_mul($instruction);
                $total += $curr;
            }
        }
    }
    return $total;
}

sub eval_mul {
    my ($instruction) = @_;
    if ($instruction =~ /mul\((\d+),(\d+)\)/) {
        my ($a, $b) = ($1, $2);
        return $1 * $2;
    }
    else {
        die "Bad instruction op '$instruction'";
    }
}

__END__

--- Day 3: Mull It Over ---
"Our computers are having issues, so I have no idea if we have any Chief Historians in stock! You're welcome to check the warehouse, though," says the mildly flustered shopkeeper at the North Pole Toboggan Rental Shop. The Historians head out to take a look.

The shopkeeper turns to you. "Any chance you can see why our computers are having issues again?"

The computer appears to be trying to run a program, but its memory (your puzzle input) is corrupted. All of the instructions have been jumbled up!

It seems like the goal of the program is just to instructiontiply some numbers. It does that with instructions like instruction(X,Y), where X and Y are each 1-3 digit numbers. For instance, instruction(44,46) instructiontiplies 44 by 46 to get a result of 2024. Similarly, instruction(123,4) would instructiontiply 123 by 4.

However, because the program's memory has been corrupted, there are also many invalid characters that should be ignored, even if they look like part of a instruction instruction. Sequences like instruction(4*, instruction(6,9!, ?(12,34), or instruction ( 2 , 4 ) do nothing.

For example, consider the following section of corrupted memory:

xinstruction(2,4)%&instruction[3,7]!@^do_not_instruction(5,5)+instruction(32,64]then(instruction(11,8)instruction(8,5))
Only the four highlighted sections are real instruction instructions. Adding up the result of each instruction produces 161 (2*4 + 5*5 + 11*8 + 8*5).

Scan the corrupted memory for uncorrupted instruction instructions. What do you get if you add up all of the results of the instructiontiplications?


