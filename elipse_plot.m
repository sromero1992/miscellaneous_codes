%Elipse plote
r=0:0.1:1;
t=0:0.1:2*pi;
a=3;
b=2;
r1=0:0.1:a;
r2=0:0.1:b;
x=r1.*cos(t);
y=r2.*sin(t);

plot(x,y)