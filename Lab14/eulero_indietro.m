function [th,uh,iter_pf]=eulero_indietro(f,t_0,t_max,y0,h)
    % Funzione che approssima la soluzione di un'equazione differenziale
    % th = vettore dei passi di discretizzazione del metodo
    % uh = matrice che ad ogni colonna approssima y al passo th
    % iter_pf= vettore del numero di iterazioni necessarie per ogni passo di uh

    th = t_0:h:t_max;
    N=length(th);
    uh(:,1) = y0;
    iter_pf=zeros(1,N);
    nmax=1000;
    toll=1e-5;
    for n=1:(N-1)
        err=toll+1;
        niter=0;
        phi=@(u) uh(:,n)+h*f(th(n+1),u); 
        while(err>toll && k<nmax)
            err=norm(phi(uh(:,n))-uh(:,n));
            niter=niter+1;
            uh(:,n+1)=phi(uh(:,n));
        end
        iter_pf(n+1)=niter;
    end
end
