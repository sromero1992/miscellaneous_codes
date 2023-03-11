   clc
    A=[1 2 3; 2 -1 1; 3 0 -1];
    b=[9;8;3];
    x=[0;0;0];

    r = b - A * x;
    p = r;
    rsold = r' * r;

    for i = 1:3
        Ap = A * p
        alpha = rsold / (p' * Ap)
        x = x + alpha * p;
        r = r - alpha * Ap;
        rsnew = r' * r;
        if sqrt(rsnew) < 1e-6
              break;
        end
        p = r + (rsnew / rsold) * p;
        rsold = rsnew;
    end
    i
    x