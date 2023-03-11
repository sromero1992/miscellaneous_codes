%Correction for function b) of problem 6

n=1:15;%points of the mesh

x0=10.^-n;%values for the mesh

m=1;
% reformulation of function b with Taylor around zero
f5=@(x) (x-(-1).^m.*(x.^(2.*m+1)./factorial(2.*m+1))).*x.^-3;
x=10.^-n;
ft=0;
for m=1:1000;

ft=ft+ f5(x0);



end
E=[x0; f5(x0)];
fprintf('\n %7s %15s \r\n','x','f1(x)');
fprintf('%2e %15e\n',E);