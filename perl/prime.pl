#!/usr/bin/perl


sub isPrime
{
	if (@_[0] == 1 || @_[0] == 3 || @_[0] == 5)
	{
		return 1;
	}
	elsif (@_[0]% 2 == 0)
	{
		return 0;
	}
	elsif(@_[0] % 3 == 0)
	{
		return 0;
	}
	elsif(@_[0] % 5 == 0)
	{
		return 0;
	}
	else
	{
		return 1;
	}

}

print "Please input an upper pound for primes: ";
my $input = <>;

for ($i = 1; $i < $input; $i++)
{
	if (isPrime($i))
	{
		print "\n $i";
	}
}
