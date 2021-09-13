#!/usr/bin/perl


#A short program to list out all prime numbers between 1
#and a user input



use warnings;
use strict;

#Determines if a number is prime by checking possibile dividers
#It is assumed than an even number (not prime) is not input
sub isPrime
{
	if ($_[0] == 1 || $_[0] == 3 || $_[0] == 5 || $_[0] == 7)
	{
		return 1;
	}
	elsif($_[0] % 3 == 0)
	{
		return 0;
	}
	elsif($_[0] % 5 == 0)
	{
		return 0;
	}
	elsif($_[0] % 7 == 0)
	{
		return 0;
	} 

	#Checks odd numbers above 7,
	#If a numer's square is out of bounds, then that number will not be pared with
	#a number greater than itself
    my $l;
	for($l = 11; $l * $l <= $_[0]; $l += 2)
	{
		if($_[0] % $l == 0)
		{
			return 0;
		}
	}

	return 1;
}

print "Please input an upper bound for primes: ";
my $input = <>;
my @Arr = ();
my $count = 0;
my $i;

#Iterates only odd numbers to save run-time
for ($i = 1; $i<= $input; $i += 2)
{
	if (isPrime($i))
	{
        $Arr[$count] = $i; 
        $count++;
		print "\n $i";
	}
}

print "\n";