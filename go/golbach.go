package main

import "fmt"
import "math"


func main(){
	var userInput int = 0
	var primeArray []int

	for userInput < 7 || userInput % 2 == 0{
		fmt.Println("Please enter an odd number greater than 7: ");
		fmt.Scanln(&userInput);
	}

	
	for number:=1; number < userInput; number+=2{
		if (isPrime(number)){
			primeArray = append(primeArray, number)
		}
	}

	goldArray := goldbach(primeArray, userInput)
	
	printAnswer(goldArray, userInput)
	
}


func isPrime(number int) bool {
	for  checkNum := 3; (checkNum * checkNum) <= number; checkNum+=2{
		if (number % checkNum == 0){
			return false
		}
	}
	return true
}

func calcNorm(i int, j int, k int) float64{
	var i_f float64 = float64(i)
	var j_f float64 = float64(j)
	var k_f float64 = float64(k)
	var ret float64
	ret = math.Sqrt((i_f*i_f)+(j_f*j_f)+(k_f*k_f))
	return ret
}

func goldbach(primeArray []int, userInput int) [3]int{
	var k int
	var j int
	var i int
	var norm float64 = 0.0
	var newNorm float64
	var goldArray [3]int

	for k_pos := len(primeArray)-1;k_pos> len(primeArray) / 3; k_pos--{
		k = primeArray[k_pos]
		
		for j_pos:=k_pos-1;j_pos>0; j_pos--{
			j = primeArray[j_pos]
			i = userInput - k - j
			
			if isPrime(i) && i < j{
				newNorm = calcNorm(i,j,k)
				
				if newNorm < norm || norm == 0.0 {
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