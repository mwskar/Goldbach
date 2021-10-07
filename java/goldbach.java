import java.io.*;



public class goldbach
{

    //////////////////////////////////////
    //              Main
    //////////////////////////////////////
    public static void main(String [] args)
    {
        String s_userInput;
        int userInput;
        Console read = System.console();
        int [] answer = {};

        System.out.print("Please enter a number greater than 7 and odd: ");
        try
        {
            userInput = Integer.parseInt(read.readLine());

            if (userInput > 7 && userInput % 2 != 0)
            {
                int [] primeList = genPrimes(userInput);
                answer = calcGoldbach(primeList, primeList.length, userInput);
                System.out.printf("%d : (%d, %d, %d)\n",userInput, answer[0], answer[1], answer[2]);
            }
            else
            {
            System.out.printf("A number was entered that is even or less than or equal to 7\n");
            }
            
        }
        catch (NumberFormatException e)
        {
            System.out.printf("An invalid value has been entered\n");
        }

    }


    ///////////////////////////////////
    //          Functions
    ///////////////////////////////////

    //Determines if a number is prime by checking possibile dividers
    //It is assumed than an even number is not input
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
    
    //Genterates all odd numebrs up to the user's input (evens will never be prime)
    //The prime numbers are kept and returned
    private static int[] genPrimes(int userInput)
    {
        int [] primeArr = {};
        int [] tempArr = {};
        for (int check = 1; check < userInput; check+=2)
        {  
            if (isPrime(check))
            {
                //Moves values into a temp array, 
                //moves back to a larger origional array
                
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

    //Calculates the vector norm of three numbers (v = sqrt(i^2 + J^2 + k^2))
    private static double calcNorm(int i, int j, int k)
    {  
        double x,y,z;
        x = i;
        y = j;
        z = k;
        return Math.sqrt((x*x)+(y*y)+(z*z));
    }

    //Tests the Goldbach conjecture by iterating through possible prime combinations
    //The answer vector will have the highest 'i' value associated with the lowest 'norm'
    private static int[] calcGoldbach(int [] list, int arrSize, int userInput)
    {
        int k_pos, j_pos;
        int i,j,k;
        double norm, newNorm;
        norm = 0.0;
        int [] answer = {0,0,0};

        //Iterate backward starting from the end of the list to the begining third
        for (k_pos = arrSize - 1; k_pos > arrSize / 3; k_pos--)
        {
            k = list[k_pos];
            
            //Iterate backward from before k_pos to the second position
            for (j_pos = k_pos -1; j_pos > 0; j_pos--)
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

                    //Updates norm and answer vector
                    if (norm == 0.0 || newNorm < norm)
                    {
                        norm = newNorm;
                        answer[0] = i;
                        answer[1] = j;
                        answer[2] = k;
                    }
                    else if (newNorm == norm && i > answer[0])
                    {
                        norm = newNorm;
                        answer[0] = i;
                        answer[1] = j;
                        answer[2] = k;
                    }
                }
            }
        }

        return answer;
    }

}