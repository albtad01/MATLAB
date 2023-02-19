function [x, k] = gradiente(A, b, P, x0, tol, nmax)
    x=x0;
    r=b-A*x;
    k=0;
    err=tol+1;
    while err>tol && k<nmax
        z=P\r;
        alphak=(z'*r)/(z'*A*z);
        x=x+alphak*z;
        r=b-A*x;
        err=norm(r,2)/norm(b,2);
        k=k+1;
    end
    if (err < tol)
        fprintf('Richardson converge in %d iterazioni \n', k)
    else
        fprintf('Richardson non converge in %d iterazioni. \n', k) 
    end
end