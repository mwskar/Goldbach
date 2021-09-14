program prime

integer i

do i = 0, 100,1
        call printPrime(i)
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

integer i

if (mod(i,2) /= 0) then
        isPrime = .true.
else 
        isPrime = .false.
end if

end function isPrime

