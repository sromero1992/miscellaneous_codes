clc,clear;
N=100;
A(N,N)=0;
B(N,N)=0;
for i=1:N
    for j=1:N
      A(i,j)=i+j;
      B(i,j)=i+j;   
    end 
end

C=A*B;
C(N,N)