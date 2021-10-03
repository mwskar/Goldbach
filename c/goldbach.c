#include <stdio.h>
#include <math.h>

void genPrimes(int userInput, int * list, int *arrSize);
int isPrime(int x);
int  * append(int * primeList, int arrSize, int newNum);
void calcGoldbach(int list [], int arrSize, int userInput);
double calcNorm(int i, int j, int k);

int main()
{
    int userInput;
    
    int arrSize = 0;


    printf("Plese enter a number for the upper bound: ");
	scanf("%d", &userInput);

    if (userInput < 8 || userInput % 2 == 0)
    {
        printf("Error: The number input was either less than or equal to 7 or was even\n");
        return 0;
    }

    int list [(userInput / 3)];

	genPrimes(userInput, list, &arrSize);
    calcGoldbach(list, arrSize, userInput);

	return 0;
}

void genPrimes (int userInput, int * list, int *arrSize)
{
    int holder;

	for (int i = 1; i < userInput; i = i + 2)
	{
		if (isPrime(i))
		{
            holder = *arrSize;
            //printf("Holder = %d\n", holder);
			//printf("Adding : %d \n", i);
            list[holder] = i;
            //printf("List now has : %d\n", list[holder]);
            *arrSize = holder + 1;
		}
	}
}


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

int * append(int * primeList, int arrSize, int newNum)
{
    printf("Size : %d \n", arrSize);
    int tempArr [arrSize + 2];
    //printf("Last number is : %d\n", *(primeList+ 2));
    for (int i = 0; i < arrSize; i++)
    {
        printf("transfering : %d \n", *(primeList + i));
        tempArr[i] = *(primeList + i);
    }

    tempArr[arrSize - 1] = newNum;
    printf("Last object in arr is now %d \n", tempArr[arrSize -1]);

    primeList = NULL;
    primeList = tempArr;


    printf("Printing pointer\n");
    for (int k = 0; k< arrSize; k++)
            {
                printf("%d \n", *(primeList + k));
            }
    
    return primeList;
}

double calcNorm(int i, int j, int k)
{
    double x,y,z;
    x = (double) i;
    y = (double) j;
    z = (double) k;
    return ((i * i)+(j * j)+(k * k));
}

void calcGoldbach(int list [], int arrSize, int userInput)
{
    int k_pos, j_pos;
    int i,j,k;
    double norm, newNorm;
    norm = 0.0;
    int answer [3] = {0,0,0};


    for (k_pos = arrSize - 1; k_pos > arrSize / 3; k_pos--)
    {
        k = list[k_pos];
        //printf("%d\n", k);
        for (j_pos = k_pos -1; j_pos > 0; j_pos--)
        {
            j = list[j_pos];

            i = userInput - k - j;

            if (i < j && isPrime(i))
            {
                newNorm = calcNorm(i,j,k);
                if (norm == 0.0 || newNorm < norm)
                {
                    //printf("changing values");
                    norm = newNorm;
                    answer[0] = i;
                    answer[1] = j;
                    answer[2] = k;
                }
            }
        }
    }

    printf("%d : (%d, %d, %d)\n",userInput, answer[0], answer[1], answer[2]);
}