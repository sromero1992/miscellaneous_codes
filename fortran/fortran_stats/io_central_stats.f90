program read
implicit none
integer :: n_col=14, n_row=142
character(4), dimension(1,14) :: names
real, dimension(142,14) :: dat
real :: av1(142,1), av(13), ssum,diff(142,1), sd(13), var, rang, slice, cn(10), minv, maxv
integer:: i, j, k, mounth, coun, interv


open(10,file='central_temps.txt')
read(10,*) (names(1,j),j=1,14)
read(10,*) ((dat(i,j),j=1,14),i=1,142)
close(10)
!print the data
!do i=1,142
!write(*,*) dat(i,:)
!end do

!calc average of each column
ssum=0
do i=1,n_col-1   
        do j=1,n_row
        ssum=ssum+dat(j,i+1)
        end do
av(i)=ssum/n_row
ssum=0
end do

do i=1,n_col-1
        write(*,*) 'The averages temp for ',names(1,i+1) ,' is ',  av(i)
end do

!standard deviation for each month
var=0
do i=1,n_col-1
       do j=1,n_row 
       var=var + (dat(j,i+1)-av(i))**2   
       end do
sd(i)=sqrt(var/142)
var=0
end do
do i=1,n_col-1
        write(*,*) 'The standard deviation for ',names(1,i+1),' is ', sd(i)
end do
!file for averages
open(5,file='data_av.txt')
!write(5,*) av(:)! save as row
!save as column
do i=1,12
write(5,*)i, av(i)
end do
close(5)

!!ploting averages
call system('gnuplot -p plot_av.txt')

!file for a month, do first frequency count
coun=0
mounth=1
minv=minval(dat(:,mounth+1))
maxv=maxval(dat(:,mounth+1))
rang=maxv-minv
interv=10
slice=rang/interv
write(*,*) 'The range is: ',rang, ' min val: ', minv, 'max val:', maxv
write(*,*) 'The interval of histo: ' , slice
do j=1,interv
        do i=1,142
                if( (minv+(j-1)*slice) .LE. dat(i,mounth+1) .AND. dat(i,mounth+1).LE. (minv+j*slice) ) then      
                coun=coun+1
                end if
                cn(j)=coun
        end do
        coun=0
end do
!data file with frequencies of the mounth
open(7,file='temp_freq_m.txt')
do j=1,interv
        write(7,*)(minv+j*slice),cn(j)       
end do
!!ploting histograms of a desired month
call system('gnuplot -p plot_histo.txt')


end program 


