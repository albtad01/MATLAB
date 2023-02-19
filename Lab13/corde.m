function [xvect, niter] = corde(a, b, x0, kmax, tol, fun)
    q=(fun(b)-fun(a))/(b-a);
    niter=0; % xvect è lungo al massimo kmax+1
    xvect=x0;
    xv=x0;
    err=tol+1;
    while niter<=kmax && err>=tol
        xn=xv-fun(xv)/q;
        niter=niter+1;
        err=abs(fun(xn)); % Criterio del Residuo
        xvect=[xvect xn];
        xv=xn;
    end
end