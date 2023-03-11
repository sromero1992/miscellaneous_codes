program sum
      real a,b,c,d,e,s
      character stg
      print *, 'This program calculate a sum'
      print *, ' Do you want to do an entry?:(y/n)'
      read *, stg
      
      if (stg == 'n') then
        a=1
        b=2
        c=3
        d=4
        e=5
        s=a+b+c+d+e
        print *,'The sum of',a,'+',b,'+',c,'+',d,'+',e,'=',s
      else
        print *, 'Capture the 5 numbers:'
        read *, a,b,c,d,e
         s=a+b+c+d+e
        print *, 'The sum is:',s
      end if  
end program sum
                






