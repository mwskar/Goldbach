package main

import "fmt"
import "math"

/*
/////////////////////////////////////
			Main Program
/////////////////////////////////////
*/


func main(){
	var userInput int = 0
	var testInput float64 = 0.0
	var hldr int;

		//Gets user input
		fmt.Println("Please enter an odd number greater than 7: ");
		fmt.Scanln(&testInput);
		

		//Prevents entering a float
		hldr = int(testInput * 10.0)
		if (hldr % 10 != 0){
			fmt.Println("Please enter an integer");
			return
		}
	
		userInput = int(testInput)
		//Determines if user input is valid
		//If so runs the program
		if (userInput > 7 && userInput % 2 != 0){

			primeArray := genPrimes(userInput)

			goldArray := goldbach(primeArray, userInput)
	
			printAnswer(goldArray, userInput)
		} else{
			fmt.Println("Eror:")
			fmt.Println("-Number was either not greater than 7 or was even")
			fmt.Println("-Or a non number was entered")
			
		}

}


/*
/////////////////////////////////////
			Functions
/////////////////////////////////////
*/


//Genterates all odd numebrs up to the user's input (evens will never be prime)
//The prime numbers are kept and returned
func genPrimes(userInput int) [] int{
	var primeArray []int;

	for number:=1; number < userInput; number+=2{
		if (isPrime(number)){
			primeArray = append(primeArray, number)
		}
	}

	return primeArray
}


//Determines if a number is prime by checking possibile dividers
//It is assumed than an even number is not input
func isPrime(number int) bool {
	for  checkNum := 3; (checkNum * checkNum) <= number; checkNum+=2{
		if (number % checkNum == 0){
			return false
		}
	}
	return true
}


//Calculates the vector norm of three numbers (v = sqrt(i^2 + J^2 + k^2))
func calcNorm(i int, j int, k int) float64{
	var i_f float64 = float64(i)
	var j_f float64 = float64(j)
	var k_f float64 = float64(k)
	var ret float64
	ret = math.Sqrt((i_f*i_f)+(j_f*j_f)+(k_f*k_f))
	return ret
}


//Tests the Goldbach conjecture by iterating through possible prime combinations
//The answer vector will have the highest 'i' value associated with the lowest 'norm'
func goldbach(primeArray []int, userInput int) [3]int{
	var k int
	var j int = 1
	var i int = 0
	var norm float64 = 0.0
	var newNorm float64
	var goldArray [3]int

	//Iterate backward starting from the end of the list to the begining third
	for k_pos := len(primeArray)-1;k_pos> len(primeArray) / 3; k_pos--{
		k = primeArray[k_pos]

		//Iterate backward from before k_pos to the second position
		for j_pos:=k_pos-1;j_pos > 0; j_pos--{
			j = primeArray[j_pos]
			i = userInput - k - j
			
			if (i < 1){
				continue
			}

			if isPrime(i) && i < j{
				newNorm = calcNorm(i,j,k)
				
				//Updates norm and answer vector
				if newNorm < norm || norm == 0.0 {
					norm = newNorm
					goldArray[0] = i
					goldArray[1] = j
					goldArray[2] = k
				}else if newNorm == norm && i > goldArray[0]{
					norm = newNorm
					goldArray[0] = i
					goldArray[1] = j
					goldArray[2] = k
				}
			}
		}
	}
	return goldArray
}


//Prints out the formatted ansewer vector
func printAnswer(goldArray [3]int, userInput int){
	fmt.Print(userInput)
	fmt.Print(": (")
	for i:=0; i<len(goldArray); i++{
		fmt.Print(goldArray[i])
		if i < len(goldArray) - 1{
			fmt.Print(", ")
		}
	}
	fmt.Print(")\n")
}