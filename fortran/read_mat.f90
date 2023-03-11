subroutine read_mat(ch,ma,c,l)
 
use mat2
!counting number of lines/rows
open(50,file=ch)
l=0
do
        read(50,*,iostat=ios) dum_m
        if(ios .EQ. 0) then
        l=l+1
        else if(ios .GT.0) then
                write(*,*) 'Error reading the file, try it again'
                exit
        else
                exit
        end if
end do
close(50)
write(*,*) 'Number of rows are : ',l

!Counting number of cols
 
 
write(*,*) 'Write the size of your columns : '
read(*,*) c

write(*,*) 'your matrix is :',l,' x ',c


open(50,file=ch)
!Allocating the matrix

do k=1,l
        read(50,*,iostat=ios) (ma(k,j),j=1,c)
end do

close(50)

return
 
end subroutine read_mat

