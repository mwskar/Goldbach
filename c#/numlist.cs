using System;

public class Numlist
{
	static public void Main()
	{
		int number;
		Console.WriteLine ("Enter a number:");
		String str = Console.ReadLine();
		number = Convert.ToInt32(str);
		for (int i = 1; i<number; i+=2)
		{
			if(isPrime(i))
			{	
				Console.WriteLine(i);
			}
		}
	}
 
  public static bool isPrime(int number)
  {
	for (int i = 3; i < number; i+=2)
	{
		if (number % i == 0)
		{
			return false;
		}
	}
	return true;	
  }
 
}


