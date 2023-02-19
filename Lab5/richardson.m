function [xk,k]= richardson(A,b, P, x0, tol, nmax, alpha)
    x=x0;
    % xn=x0; xv=x0;
    r=b-A*x;
    k=0;
    err=tol+1;
    xk= [x0];
    while err>tol && k<nmax
        x=x+alpha*(P\r); % P scelto comodo; xn=xv+... 
        r=b-A*x;
        err=norm(r,2)/norm(b,2);
        xk=[xk x];
        % err=norm(xn-xv) nel mio codice
        k=k+1;
        % xv=xn
        
    end
    % x=xn
%     xn=x0;
%     xv=x0;
%     resn=tol+1;
%     ii=0;
%     while resn>tol & ii<nmax
%         xn=xv+alpha*inv(P)*resn;
%         rk=b-A*xn;
%         resn=norm(rk)/norm(b);
%         ii=ii+1;
%         xv=xn
%     end
%     x=xn;
%     k=ii;
