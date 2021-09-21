#include <stdio.h>

int isPrime(int x);


int main()
{
	int input;

	printf("Plese enter a number for the upper bound: ");
	scanf("%d", &input);
	//printf("%d", input);
	
	for (int i = 1; i < input; i= i + 2)
	{
		
		if (isPrime(i))
		{
			printf("%d \n", i);
		}

	}

	return 0;
}


int isPrime(int x)
{
	int ret = 1;
	for(int i =2; i<x; i++)
	{
		if (x % i == 0)
		{
			ret = 0;
		}
	} 
	return ret;	
}

