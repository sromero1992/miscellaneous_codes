%Gauss-Seidel method to solve matrixes and vectors.
%of the form Ax =b
%Problem 4.6.1 computer a)
clc, clear
x=0;
y=0;
z=0;
er=10^-4;
for i=1:9
    xless = x;
    x = (-y-z+5)/3;
    yless = y;
    y = -3*x+5*z-1;
    zless = z;
    z = x+3*y-3;
    if (abs(x-xless) < er)&&(abs(y-yless) < er)&&(abs(z-zless) < er)
        break;
    end

end
fprintf('The values are:');
x
y
z
fprintf('in the iteration:');
i