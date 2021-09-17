program prime

call printPrime(1, 100)
 
end program


recursive subroutine printPrime(i, upperBound)
        integer i 
        integer upperBound
        logical isPrime
        
        if (i < upperBound) then
                call printPrime(i + 2, upperBound)
        
        if (isPrime(i)) then
                print *, i
        end if
end subroutine printPrime



logical function isPrime(i)

implicit none
integer :: i, x 

isPrime = .true.

x = 3
do while (x * x <= i)
        if(mod(i,x) == 0) then
                isPrime = .false.
        end if
        x = x + 2
end do

end function isPrime

