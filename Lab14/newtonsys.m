function [xvect, it] = newtonsys(x0, nmax, toll, fun, J)
    xvect=x0;
    err=toll+1;
    it=0;
    x_old=x0;
    while(it<nmax && err>toll)
        % errore -> (1) norma del residuo o (2) DIFFERENZA ITERATE  (capire quale meglio)
        x_new=x_old-J(x_old)\fun(x_old); 
        % x_new=x_old-fun(x_old)/J(x_old), analogamente a 1D, però non posso fare la divisione,
        % quindi risolvo un sistema lineare con \
        err=norm(x_new-x_old,inf);
        it=it+1;
        x_old=x_new;
    end
    xvect=x_new;
    % si richiede soltanto la soluzione xvect, non lo storico delle iterate
end