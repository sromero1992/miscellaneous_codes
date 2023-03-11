%Gaussian elimination problem 4.6.1 computer
clc,clear
%A=[3 1 1; 1 3 -1; 3 1 -5]; %Case A
A=[3 1 1; 3 1 -5; 1 3 -1]
%b=[5; 3; -1]; %Case A
b=[5; -1; 3] %Case B 
%AT(3,3)=zeros;
Ainv=diag(ones(3,1));
n=3;

for k=1:n-1
    for i=k+1:n
    z=-A(i,k)/A(k,k);
    A(i,k)=0;
    Ainv(i,k)=z;
        for j=k+1:n
            A(i,j)=A(i,j)+z*A(k,j);
        end
    
    end
end
bt=Ainv*b;
A
bt

