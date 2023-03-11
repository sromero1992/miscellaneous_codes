program drift

real(8) :: nfor, cfr, cfd, netf, v,vs
character(32) :: veh, bol,cli


10      write(*,*)'Capture/read the model of the vehicle'
        read(*,*) veh
        write(*,*) 'your car is:',veh,'is it right?(y/n) :'
        read(*,*)bol
        if(bol.eq.'n') then
                go to 10
        end if
        !here I need to read a list of a txt file where has cars and weights

        write(*,*) 'Is it raining?(y/n) :'
        read(*,*) bol
        if (bol .eq. 'y') then
               cf=cfr
        else then
               cf=cfd 
        end if
        netf=

        write(*,*) 'The maximum speed to be safe is: ', 





        end program drift
