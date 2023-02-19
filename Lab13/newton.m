function [x_vect, it] = newton( x0, nmax, toll, fun, dfun, mol )
    x_vect=x0;
    err=toll+1;
    it=0;
    x_old=x0;

    while(it<nmax && err>toll)
        fx=fun(x_old);
        dfx=dfun(x_old);
        if dfx==0
            % error fa terminare l'esecuzione della function
            error('Arresto per azzeramento di dfun');
        end
        % nuova iterazione di newton
        x_new=x_old-mol*fx/dfx;
        err=abs(x_new-x_old);
        it=it+1;
        % salvo le quantità di interesse negli output
        x_vect=[x_vect x_new]; % creo vettore della successione che convergerà alla radice
        x_old=x_new;
    end
end