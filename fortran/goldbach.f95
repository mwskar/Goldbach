
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!             The program
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

program goldbach

integer:: userInput, errFlag = 0
integer, dimension(:), allocatable :: primeList
integer, dimension(3) :: answer


userInput = 0
print *, "Please enter an odd number greater than 7: "
read*, userInput


if (userInput > 7 .and. mod(userInput, 2) /= 0) then
        call genPrimes(userInput, primeList)

        call calcGoldbach(userInput, primeList, answer)

        call printAnswer(userInput, answer)
else 
        print *, "A number was entered that is even or less than or equal to 7"
end if



contains

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!                 Subroutines
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


!!Genterates all odd numebrs up to the user's input (evens will never be prime)
!!The prime numbers are kept and returned
subroutine genPrimes(userInput, primeList)

        integer :: current_number, arrLen
        integer, intent (in) :: userInput
        integer, dimension (:), allocatable :: numArr, tempArr
        logical :: isPrime
        integer, dimension(:), allocatable, intent (out) :: primeList

        current_number = 1
        allocate (numArr(0))
        do while (current_number < userInput)
                if (isPrime(current_number)) then
                        
                        ! Moves values into a temp array, 
                        !moves back to a larger origional array

                        arrLen = size(numArr) + 1
                        allocate (tempArr(arrLen))
                        tempArr(1:arrLen-1) = numArr
                        tempArr (arrLen) = current_number
                        
                        deallocate (numArr)
                        allocate (numArr(arrLen + 1))
                        !numArr(1:arrLen+1) = tempArr
                        numArr = tempArr
                        deallocate (tempArr)
                end if
                current_number = current_number + 2
        end do

        allocate(primeList(arrLen))

        primeList(1:) = numArr

        deallocate (numArr)
        
end subroutine genPrimes


!!Tests the Goldbach conjecture by iterating through possible prime combinations
!!The answer vector will have the highest 'i' value associated with the lowest 'norm'
subroutine calcGoldbach(userInput, primeList, answer)
        integer, intent(in) :: userInput
        integer, dimension (:), intent(in) :: primeList
        integer, dimension (3), intent(out) :: answer

        integer :: current_number, arrLen, k_spot, j_spot, k, j, i
        real (kind = 8) :: norm, newNorm, clacNorm
        integer, dimension (3) :: normArr
        logical :: isPrime

        norm = 0.0D0
        arrLen = size(primeList)
        k_spot = arrLen
        
        
        !Iterate backward starting from the end of the list to the begining third
        do while (k_spot > (arrLen / 3))
                k = primeList(k_spot)

                j_spot = k_spot - 1

                !Iterate backward from before k_pos to the second position
                do while (j_spot > 0)
                        j = primeList(j_spot)
                        i = userInput - k - j

                        if (i > 0 .and. i < j .and. isPrime(i)) then
                                newNorm = clacNorm(i,j,k)

                                !Updates norm and normArr vector
                                if (newNorm < norm .or. norm == 0) then
                                        !Holds onto the new data
                                        
                                        norm = newNorm
                                        normArr(1) = i
                                        normArr(2) = j
                                        normArr(3) = k
                                else if (newNorm == norm .and. i > normArr(1)) then
                                        norm = newNorm
                                        normArr(1) = i
                                        normArr(2) = j
                                        normArr(3) = k
                                end if
                        end if
                        j_spot = j_spot - 1
                end do
                k_spot = k_spot - 1
        end do


        answer(1:) = normArr

end subroutine calcGoldbach 


!!Prints out a formated answer vector
subroutine printAnswer(userInput, answer)
        integer, dimension(3), intent (in) :: answer
        integer, intent (in) :: userInput
        print *, userInput, ": ( ", answer(1), ",", answer(2), ",", answer(3), ")"
end subroutine printAnswer


end program goldbach

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!                      Functions
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


!!Determines if a number is prime by checking possibile dividers
!!It is assumed than an even number is not input
logical function isPrime(current_number)
        integer :: current_number, check_number

        check_number = 3
        isPrime = .true.

        do while (check_number**2 <= current_number)
                if (mod(current_number, check_number) == 0) then
                        isPrime = .false.
                        EXIT
                end if
                check_number = check_number + 2
        end do
end function isPrime

!!Calculates the vector norm of three numbers (v = sqrt(i^2 + J^2 + k^2))
real (kind = 8) function clacNorm(i,j,k)
        integer :: i,j,k
        clacNorm = sqrt((real(i, kind = 8)**2) + (real(j, kind = 8)**2) &
         + (real(k, kind = 8)**2))
end function clacNorm 
