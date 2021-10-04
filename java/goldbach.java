import java.io.*;



public class goldbach
{
    public static void main(String [] args)
    {
        String s_userInput;
        int userInput;
        Console read = System.console();

        System.out.print("Please enter a number greater than 7 and odd: ");
        //s_userInput =  Console.readLine("Please enter an odd number greater than 7: ");
        //System.out.println(s_userInput);
        userInput = Integer.parseInt(read.readLine());

        int [] primeList = genPrimes(userInput);
        calcGoldbach(primeList, primeList.length, userInput);

    }

    private static boolean isPrime(int number)
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

    private static int[] genPrimes(int userInput)
    {
        int [] primeArr = {};
        int [] tempArr = {};
        for (int check = 1; check < userInput; check+=2)
        {  
            if (isPrime(check))
            {
                tempArr = new int [primeArr.length + 1];
                for (int i = 0; i < primeArr.length; i++)
                {
                    tempArr[i] = primeArr[i];
                }
                tempArr[tempArr.length -1] = check;

                primeArr = new int [tempArr.length];
                for (int l = 0; l < tempArr.length; l++)
                {
                    primeArr[l] = tempArr[l];
                }
            }
        }
        return primeArr;
    }

    private static double calcNorm(int i, int j, int k)
    {  
        double x,y,z;
        x = i;
        y = j;
        z = k;
        return Math.sqrt((x*x)+(y*y)+(z*z));
    }

    private static void calcGoldbach(int [] list, int arrSize, int userInput)
    {
        int k_pos, j_pos;
        int i,j,k;
        double norm, newNorm;
        norm = 0.0;
        int [] answer = {0,0,0};


        for (k_pos = arrSize - 1; k_pos > arrSize / 3; k_pos--)
        {
            k = list[k_pos];
            for (j_pos = k_pos -1; j_pos > 0; j_pos--)
            {
                j = list[j_pos];

                i = userInput - k - j;

                if (i < j && isPrime(i))
                {
                    newNorm = calcNorm(i,j,k);
                    if (norm == 0.0 || newNorm < norm)
                    {
                        norm = newNorm;
                        answer[0] = i;
                        answer[1] = j;
                        answer[2] = k;
                    }
                }
            }
        }

        System.out.printf("%d : (%d, %d, %d)\n",userInput, answer[0], answer[1], answer[2]);
    }

}