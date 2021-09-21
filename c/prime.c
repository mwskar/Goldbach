#include <stdio.h>

void doStuff(void);
int isPrime(int x);


int main()
{
	doStuff();
	return 0;
}

void doStuff (void)
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

