program date_time
      implicit none
      
      character(10):: date, time, zone
      integer,dimension(8):: values
      call date_and_time(date,time,zone,values)
      call date_and_time(DATE=date,ZONE=zone)
      call date_and_time(TIME=time)
      call date_and_time(VALUES=values)
      print '(a,2x,a,2x,a)', date, time, zone
      print'(8i6)', values

      end program date_time
