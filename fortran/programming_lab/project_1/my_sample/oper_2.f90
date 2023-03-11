program oper_2
implicit none
real(8) :: a,b,c
real(8) :: mult_func

write(6,*) 'Capture values of a and b'
read(*,*) a,b

c=mult_func(a,b)

write(6,*) 'Mult=', c

call swap(a,b)

write(6,*) 'now a=', a, 'and b=', b 


   end program oper_2
