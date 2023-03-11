%This program study the loss-of-significance error 
%also it has the main function and its reformulation.
%format long e
n=1:15;%points of the mesh

x0=10.^-n;%values for the mesh

f1=@(x) (sqrt(4+x)-2)./x;
f2=@(x) (x-sin(x))./(x.^3);
f1(x0);
f2(x0);
%Reformulation
f3=@(x) 1./(sqrt(4+x)+2);
f4=@(x) (x.^2+(cos(x)).^2-1)./((x.^3).*(x+sin(x)));
f3(x0);
f4(x0);
A=[x0; f1(x0)];
B=[x0; f2(x0)];
C=[x0; f3(x0)];
D=[x0; f4(x0)];
text=fopen('lossSignal','w');
fprintf(text,'\n %7s %15s \r\n','x','f1(x)');
fprintf(text,'%2e %15e\n',A);
fprintf(text,'\n %7s %15s \r\n','x','f3(x)');
fprintf(text,'%2e %15e\n',C);5
fprintf(text,'\n %7s %15s \r\n','x','f2(x)');
fprintf(text,'%2e %15e\n',B);
fprintf(text,'\n %7s %15s \r\n','x','f4(x)');
fprintf(text,'%2e %15e\n',D);
fclose(text);