#!/usr/bin/perl


sub isPrime
{
	if (@_[0] == 1 || @_[0] == 3 || @_[0] == 5 || @_[0] == 7)
	{
		return 1;
	}
	elsif(@_[0] % 3 == 0)
	{
		return 0;
	}
	elsif(@_[0] % 5 == 0)
	{
		return 0;
	}
	elsif(@_[0] % 7 == 0)
	{
		return 0;
	} 

	for($l = 11; $l * $l <= @_[0]; $l += 2)
	{
		if(@_[0] % $l == 0)
		{
			return 0;
		}
	}

	return 1;
}

print "Please input an upper bound for primes: ";
my $input = <>;

for ($i = 1; $i<= $input; $i += 2)
{
	if (isPrime($i))
	{
		print "\n $i";
	}
}

print "\n";