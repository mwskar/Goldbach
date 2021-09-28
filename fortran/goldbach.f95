program goldbach

call genPrimes

end program goldbach

subroutine genPrimes
        integer :: current_number, userInput, arrLen, k_spot, j_spot, k, j ,i
        real (kind = 8) :: norm, newNorm, clacNorm
        integer, dimension (3) :: normArr
        integer, dimension (:), allocatable :: numArr, tempArr
        logical :: isPrime
        character (len = 20) :: output, calcGoldbach


        userInput = 0
        do while (userInput < 8 .or. mod(userInput, 2) == 0)
                print *, "Please enter an odd number greater than 7: "
                read *, userInput
        end do

        current_number = 1
        allocate (numArr(0))
        do while (current_number < userInput)
                if (isPrime(current_number)) then
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


        norm = 0.0D0
        arrLen = size(numArr)
        k_spot = arrLen
        do while (k_spot > (arrLen / 3))
                k = numArr(k_spot)

                j_spot = k_spot - 1
                do while (j_spot > 0)
                        j = numArr(j_spot)
                        i = userInput - k - j
                        !print *, i,j,k
                        if (i > 0 .and. isPrime(i) .and. i < j) then
                                newNorm = clacNorm(i,j,k)
                                if (newNorm < norm .or. norm == 0) then
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

        deallocate (numArr)
        
        print *, userInput, normArr(1), normArr(2), normArr(3)
end subroutine genPrimes


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

real (kind = 8) function clacNorm(i,j,k)
        integer :: i,j,k
        clacNorm = sqrt((real(i, kind = 8)**2) + (real(j, kind = 8)**2) &
         + (real(k, kind = 8)**2))
end function clacNorm 