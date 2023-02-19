function [x,k]= richardson(A,b, P, x0, tol, nmax, alpha)
    x=x0;
    r=b-A*x;
    k=0;
    err=tol+1;
    %Ba=eye(size(A,1))-alpha*P\A;
    %if(max(abs(eig(A)))>0)
    %    error('IL METODO NON CONVERGE');
    %end
    while err>tol && k<nmax
        x=x+alpha*(P\r); 
        r=b-A*x; % x tipo xtilde
        err=norm(r,2)/norm(b,2); % criterio basato sul residuo
        k=k+1;
    end
end