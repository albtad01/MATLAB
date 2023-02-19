function [xvect, niter] = punto_fisso( phi, x0, tol, kmax )
    xvect(1)=x0;
    err=tol+1;
    ii=2;
    niter=0;
    while err>tol & niter<kmax
        xvect(ii)=phi(xvect(ii-1));
        err=abs(xvect(ii)-xvect(ii-1));
        niter=niter+1;
        ii=ii+1;
    end
end