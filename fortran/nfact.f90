! This program will calculate the factorial of a number

program nfact

        integer n,i,m;
        print* ,"This section calculates the factorial of an integer number"
        print* ,"capture the number :"
        read* , n 
        ! m=1;
        m=n 
        
        do i=1,n-1,1
                !m=i*m this goes to n instead of n-1
                m=m*(n-i)
                    
        end do

   !     print* , "The factoriar of n = ",m," is :", n
        print* , "The factoriar of n = ",n," is :", m

         if ( n < 0) then
                print* , "The number is negative and the result won'd be correct, try a positive integer"       
        end if

        
        
        
        
end
