#!/usr/bin/perl


#A short program to list out all prime numbers between 1
#and a user input

########################################
#              Functions
########################################

use Math::Complex;

#Determines if a number is prime by checking possibile dividers
#It is assumed than an even number (not prime) is not input
#Requires input of ($)
sub isPrime
{
	#Checks odd numbers before the input
	#If a numer's square is out of bounds, then that number (and the ones above it)
	#will not divide that number

    my $num = $_[0];
	for(my $check = 3; ($check * $check) <= $num; $check = $check + 2)
	{
		if($num % $check == 0)
		{
			return 0;
		}
	}

	return 1;
}

sub genPrimes
{
    my $input = $_[0];
    my $count = 0;
    my @primeArr;

    #Iterates only odd numbers to save run-time
    for (my $check = 1; $check < $input; $check += 2)
    {
        if (isPrime($check) == 1)
        {
            $primeArr[$count] = $check; 
            $count++;
        }
    }

    return @primeArr;
}

#Calculates the vector norm of three numbers (v = sqrt(i^2 + J^2 + k^2))
#requires input of (i,j,k)
sub calcNorm
{
    return sqrt(($_[0]**2) + ($_[1]**2) + ($_[2]**2));
}


sub calcGoldbach
{
    my $input = shift @_;
    my @Arr = @_;
    my $norm = 0;
    my $newNorm;
    my @normArr = (0,0,0);
    print @Arr;

    my $j = 0;
    my $k = 0;
    my $i = 0;



    #Iterates backwards through the array and check all combinations
    #Has added benefit of keeping only the largest 'i' by default
    #Only uses two loops because finding the difference will give the last number
    #Stops before one third of the array because at that point nothing can add up to the input
    for (my $k_pos = @Arr - 1; $k_pos > @Arr / 3; $k_pos--)
    {
        $k = $Arr[$k_pos];

        #Iterate backward from before k_pos to the second position
        for (my $j_pos = $k_pos - 1; $j_pos > 0; $j_pos--)
        { 
            $j = $Arr[$j_pos];
            $i = $input - $k - $j;

            #Makes sure the 'i' is viable and less than both 'k' and 'j'
            if ($i > 1 && isPrime($i) && $i < $j) 
            {
                $newNorm = calcNorm($i, $j, $k);

                #Updates norm and answer vector
                if ($norm == 0 || $newNorm < $norm)
                {
                    $norm = $newNorm;
                    @normArr = ($i, $j, $k);
                }
                elsif($newNorm == $norm && $i > $normArr[0])
                {
                    $norm = $newNorm;
                    @normArr = ($i, $j, $k);
                }
            }
        }
    }
    return @normArr;
}


my $userInput;

print "Please input an odd integer greater than 7: ";




$userInput = <>;
if ($userInput < 7 || $userInput % 2 == 0)
{
    print "Error: The number input was either even or less than or equal to 7";
}
else
{
    my @primeArr = genPrimes($userInput);
    my @normArr = calcGoldbach($userInput, @primeArr);

    #Print out info: The input number and the best three nuumebrs
    print "\n";
    print "$userInput : ($normArr[0], $normArr[1], $normArr[2]) \n";
}




