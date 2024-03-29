#!/usr/bin/perl


#A short program to list out all prime numbers between 1
#and a user input



#use warnings;
#use strict;

use Math::Complex;

#Determines if a number is prime by checking possibile dividers
#It is assumed than an even number (not prime) is not input
#Requires input of ($)
sub isPrime
{
	#Checks odd numbers before the input
	#If a numer's square is out of bounds, then that number (and the ones above it)
	#will not divide that number
    my $l;
	for($l = 3; $l * $l <= $_[0]; $l += 2)
	{
		if($_[0] % $l == 0)
		{
			return 0;
		}
	}

	return 1;
}

#Calculates the norm of three numbers, requires input of ($,$,$)
sub calcNorm
{
    return sqrt(($_[0]**2) + ($_[1]**2) + ($_[2]**2));
}

my $input;

do
{
    print "Please input an odd integer greater than 7: ";
    $input = <>;
} while ($input % 2 == 0);

my @Arr = (1,3,5,7);
my $count = 4;
my $p = 0;

#Iterates only odd numbers to save run-time
for ($p = 11; $p<= $input; $p += 2)
{
	if (isPrime($p))
	{
        $Arr[$count] = $p; 
        $count++;
	}
}


my $norm = 0;
my $newNorm;
my @normArr = (0,0,0);

my $l;
my $x;
my $j = 0;
my $k = 0;
my $i = 0;



#Iterates backwards through the array and check all combinations
#Has added benefit of keeping only the largest 'i' by default
#Only uses two loops because finding the difference will give the last number
#Stops before one third because at that point nothing can add up to the input
for ($l = @Arr; $l > @Arr / 3; $l--)
{
    $k = $Arr[$l];

    for ($x = $l - 1; $x > 0; $x--)
    { 
        $j = $Arr[$x];
        $i = $input - $k - $j;

        #Makes sure the 'i' is viable and less than both 'k' and 'j'
        if (isPrime($i) && $i < $Arr[$x]) 
        {
            $newNorm = calcNorm($i, $j, $k);
            if ($norm == 0)
            {
                $norm = $newNorm;
                @normArr = ($i, $j, $k);
            }
            elsif($newNorm < $norm)
            {
                $norm = $newNorm;
                @normArr = ($i, $j, $k);
            }
        }
    }
}


#Print out info: The input number and the best three nuumebrs
print "\n";
print "$input : ";
print "($normArr[0], $normArr[1], $normArr[2]) \n";