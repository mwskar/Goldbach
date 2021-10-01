using System;

public class goldbach
{
    static public void Main()
    {
        int userInput;
        int arrLen = 0;
        int [] primeList = new int [1] {1};
        int [] tempList = new int[0];

		Console.Write ("Enter an odd number greater than 7: ");
		String str = Console.ReadLine();
		userInput = Convert.ToInt32(str);


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


        printAns(goldCalc(primeList, userInput), userInput);
    }

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

    public static double calcNorm(int i,int j,int k)
    {
        return Math.Sqrt((i * i)+(j * j )+(k * k));
    }

    public static int [] goldCalc(int[] primeList, int userInput)
    {
        double norm = 0.0;
        double newNorm;
        int [] goldList = new int[3] {0,0,0};
        int i;
        int j;
        int k;
        int arrLen = primeList.Length-1;

        for (int k_pos = arrLen; k_pos > arrLen / 3; k_pos--)
        {
            k = primeList[k_pos];
            for (int j_pos = k_pos -1; j_pos > 0; j_pos--)
            {
                j = primeList[j_pos];
                i = userInput - k - j;

                if (i < j  && isPrime(i))
                {
                    newNorm = calcNorm(i,j,k);

                    if (norm == 0)
                    {
                        norm = newNorm;
                        goldList[0] = i;
                        goldList[1] = j;
                        goldList[2] = k;
                    }
                    else if(newNorm < norm)
                    {
                        norm = newNorm;
                        goldList[0] = i;
                        goldList[1] = j;
                        goldList[2] = k;
                    }
                    else if (newNorm == newNorm && i > goldList[0])
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