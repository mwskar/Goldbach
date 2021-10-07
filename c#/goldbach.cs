using System;

public class goldbach
{
    //////////////////////////////////////
    //              Main
    //////////////////////////////////////
    static public void Main()
    {
        int userInput;
        int [] primeList = {};

		Console.Write ("Enter an odd number greater than 7: ");
		String str = Console.ReadLine();
		
        try
        {
            userInput = Convert.ToInt32(str);
            primeList = genPrimes(userInput);
            printAns(goldCalc(primeList, userInput), userInput);
        }
        catch(System.FormatException)
        {
            Console.Write("An invalid value has been entered\n");
        }

        
    }


    ///////////////////////////////////
    //          Functions
    ///////////////////////////////////


    //Genterates all odd numebrs up to the user's input (evens will never be prime)
    //The prime numbers are kept and returned
    public static int [] genPrimes(int userInput)
    {
        int arrLen = 0;
        int [] primeList = new int [1] {1};
        int [] tempList = new int[0];
        for (int testNum = 3; testNum<userInput; testNum+=2)
		{
			if(isPrime(testNum))
			{	
                arrLen = primeList.Length;

                tempList = new int [arrLen + 1];
                Array.Copy(primeList, tempList, arrLen);
                tempList[arrLen] = testNum;
				primeList = new int [tempList.Length];
                arrLen++;
                Array.Copy(tempList, primeList, arrLen);
			}
		}
        return primeList;
    }

    //Determines if a number is prime by checking possibile dividers
    //It is assumed than an even number is not input
    public static bool isPrime(int number)
    {
	    for (int check = 3; check * check <= number; check+=2)
	    {
		    if (number % check == 0)
		    {
			    return false;
		    }
	    }
	    return true;	
    }

    //Calculates the vector norm of three numbers (v = sqrt(i^2 + J^2 + k^2))
    public static double calcNorm(int i,int j,int k)
    {
        return Math.Sqrt((i * i)+(j * j )+(k * k));
    }

    //Tests the Goldbach conjecture by iterating through possible prime combinations
    //The answer vector will have the highest 'i' value associated with the lowest 'norm'
    public static int [] goldCalc(int[] primeList, int userInput)
    {
        double norm = 0.0;
        double newNorm;
        int [] goldList = new int[3] {0,0,0};
        int i;
        int j;
        int k;
        int arrLen = primeList.Length-1;


        //Iterate backward starting from the end of the list to the begining third
        for (int k_pos = arrLen; k_pos > arrLen / 3; k_pos--)
        {
            k = primeList[k_pos];

            //Iterate backward from before k_pos to the second position
            for (int j_pos = k_pos -1; j_pos > 0; j_pos--)
            {
                j = primeList[j_pos];
                i = userInput - k - j;

                if (i < 1)
                {
                    continue;
                }

                if (i < j  && isPrime(i))
                {
                    newNorm = calcNorm(i,j,k);

                    //Updates norm and goldList vector
                    if (norm == 0 || newNorm < norm)
                    {
                        norm = newNorm;
                        goldList[0] = i;
                        goldList[1] = j;
                        goldList[2] = k;
                    }
                    else if (newNorm == norm && i > goldList[0])
                    {
                        norm = newNorm;
                        goldList[0] = i;
                        goldList[1] = j;
                        goldList[2] = k;
                    }
                }
            }
        }
        return goldList;
    }


    //Prints a formated answer vector
    public static void printAns(int[] goldList, int userInput)
    {
        Console.Write("{0} : (", userInput);
        for (int i =- 0; i < goldList.Length; i++)
        {
            Console.Write("{0}", goldList[i]);
            if (i < goldList.Length-1)
            {
                Console.Write(", ");
            }
        }
        Console.Write(")\n");
    }

}