program prime

integer i
i = 1

do while (i < 100)
        call printPrime(i)
        i = i + 2
end do

end program


subroutine printPrime(i)
        integer i
        logical isPrime
        if (isPrime(i)) then
                print *, i
        end if
end subroutine printPrime



logical function isPrime(i)

implicit none
logical :: retPrime
integer :: i, x 

retPrime = .true.

x = 3
do while (x * x <= i)
        if(mod(i,x) == 0) then
                retPrime = .false.
        end if
        x = x + 2
end do

if (retPrime) then
        isPrime = .true.
else
        isPrime = .false.
end if

end function isPrime

