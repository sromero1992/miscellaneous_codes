%% This program uses Taylor series to approximate a function
clear; clc;
f=@(x) log(x+1);

x0=0.5; % we want log(1.5)
k=1;
E0=f(x0); %comparation value

En= E0-(-1)^(k+1)*x0^k/k; %Error compared to the arithmetical value

for k=2:1000:10^9

En=En-(-1)^(k+1)*x0^k/k;;
 
     if abs(En) <= 10^-5
        %sprintf('this is the iteration number: %d',k)  
        break;
     end
end
sprintf('The taylor series need at least %d. terms to have an error of 10^-5',k)
sprintf('The program accomplished the error value in the iteration %d',k)
