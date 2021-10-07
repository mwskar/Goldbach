#include <stdio.h>
#include <stdlib.h>
#include <math.h>



int * genPrimes(int userInput, int *arrSize);
int isPrime(int x);
int * calcGoldbach(int list [], int arrSize, int userInput);
double calcNorm(int i, int j, int k);


//////////////////////////////////////
//              Main
//////////////////////////////////////

int main()
{
    int userInput;
    int *primeList;
    int arrSize = 0;
    int *answer;


    printf("Plese enter an odd number greater than 7 (decimals will be rounded down): ");
        scanf("%d", &userInput);

        if (userInput < 8 || userInput % 2 == 0)
        {
            printf("Error: The number input was either even or less than or equal to 7\n");
            return 0;
        }

        primeList = genPrimes(userInput, &arrSize);
        answer = calcGoldbach(primeList, arrSize, userInput);
        printf("%d : (%d, %d, %d)\n",userInput, answer[0], answer[1], answer[2]);
	return 0;
}


///////////////////////////////////
//          Functions
///////////////////////////////////


//Genterates all odd numebrs up to the user's input (evens will never be prime)
//The prime numbers are kept and returned
int * genPrimes (int userInput, int *arrSize)
{
    int holder;
    int * tempArr;
    int * primeList;
	for (int i = 1; i < userInput; i = i + 2)
	{
		if (isPrime(i))
		{
            //Moves values into a temp array, 
            //moves back to a larger origional array

            holder = *arrSize;
            tempArr = (int *)malloc((holder + 1) * sizeof(int));
            
            for (int counter = 0; counter < holder; counter++)
            {
                *(tempArr + counter) = *(primeList + counter);
            }
            
            *(tempArr + holder) = i;

            primeList = (int*)malloc( (holder + 1)* sizeof(int));
            for (int counter = 0; counter < holder + 1; counter++)
            {
                *(primeList + counter) = *(tempArr + counter);
            }

            *arrSize = holder + 1;
		}
	}
    return primeList;
}


//Determines if a number is prime by checking possibile dividers
//It is assumed than an even number is not input
int isPrime(int number)
{
	for(int check = 3; check * check <= number; check = check + 2)
	{
		if (number % check == 0)
		{
			return 0;
		}
	} 
	return 1;	
}

//Calculates the vector norm of three numbers (v = sqrt(i^2 + J^2 + k^2))
double calcNorm(int i, int j, int k)
{
    double x,y,z, s;
    x = (double) i;
    y = (double) j;
    z = (double) k;
    s = (x * x)+(y * y)+(z * z);
    return sqrt(s);
    
}

//Tests the Goldbach conjecture by iterating through possible prime combinations
//The answer vector will have the highest 'i' value associated with the lowest 'norm'
int * calcGoldbach(int list [], int arrSize, int userInput)
{
    int k_pos, j_pos;
    int i,j,k;
    double norm, newNorm;
    norm = 0.0;

    int * answer = (int*)malloc(3 * sizeof(int));
    *(answer) = 0;
    *(answer + 1) = 0;
    *(answer + 2) = 0;

    //Iterate backward starting from the end of the list to the begining third
    for (k_pos = arrSize - 1; k_pos > arrSize / 3; k_pos--)
    {
        k = list[k_pos];

        //Iterate backward from before k_pos to the second position
        for (j_pos = (k_pos -1); j_pos > 0; j_pos--)
        {
            
            j = list[j_pos];
            i = userInput - k - j;

            if (i < 1)
            {
                continue;
            }

            if (i < j && isPrime(i))
            {
                newNorm = calcNorm(i,j,k);
                if (norm == 0.0 || newNorm < norm)
                {
                    norm = newNorm;
                    *(answer) = i;
                    *(answer + 1) = j;
                    *(answer + 2) = k;
                }
                else if(newNorm == newNorm && i > *(answer))
                {
                    norm = newNorm;
                    *(answer) = i;
                    *(answer + 1) = j;
                    *(answer + 2) = k;
                }
            }
        }
    }
    return answer;
}