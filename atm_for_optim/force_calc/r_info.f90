subroutine r_info(p,q,p_vec,u_vec,n_q,cent,p_cent)
implicit none

real(8)::q_dum,p_dum(3)
real(8),intent(inout)::p_cent(3)
real(8),allocatable,intent(inout)::q(:),p(:,:),p_vec(:,:),u_vec(:,:)
integer::i,j,k,n,ierr,bol
integer,intent(inout)::n_q,cent

10 write(*,*) 'If you have a file with the information write (1), if not (0) :'
read(*,*) bol

!This section reads from terminal
if (bol .EQ. 0) then

        write(*,*) 'Enter the number of charged particles : '
        read(*,*) n_q
        allocate(q(n_q))
        allocate(p(n_q,3))
        allocate(p_vec(n_q-1,3))
        allocate(u_vec(n_q-1,3))
        write(*,*) 'Write the position to measure the net force :'
        read(*,*) (p_cent(i),i=1,3)

!This section reads from info.txt in the current folder


else if (bol .EQ. 1) then
!Format to read is x y z q
open(50,file='info.txt')

j=0
        do
        read(50,*,iostat=ierr) (p_dum(i),i=1,3),q_dum

        if (ierr .LT. 0 ) then
                exit
        else if (ierr .GT. 0) then
                write(*,*) 'Something reading the file went wrong'
                exit
        end if
        j=j+1 
        end do
write(*,*) 'File has been read successfuly'
close(50)

else
       write(*,*) 'Try to type your choice again. ' 
       goto 10 
end if




n_q=j

write(*,*) 'Your number of charged particles is : ', n_q 

allocate(q(n_q))
allocate(p(n_q,3))
allocate(p_vec(n_q-1,3))
allocate(u_vec(n_q-1,3))




open(50,file='info.txt')

do i=1,j
        read(50,*,iostat=ierr) (p(i,k),k=1,3),q(i)
end do

close(50)
        

write(*,*) 'Your information is as follows : '
write(*,*) 'x y z q '
do i=1,j
        write(*,*) (p(i,k),k=1,3),q(i)
end do
write(*,*) 'Which one is the central charge (number) : '
read(*,*) cent
p_cent=p(cent,1:3)

return
end subroutine
