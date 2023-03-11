program circ
      real r,area,pi
      parameter  (pi=3.1416)
      print *, "This program computes the area of a circle."
      print *, "What is the radius?"
      read *, r
      area= pi*r**2
      print *, "The area is: ", area 
      print *, "That's it, see ya"
      end
