function [th,uh,iter_pf]=eulero_indietrofake(f,t_0,t_max,y0,h)
    
    th = t_0:h:t_max;
    N=length(th);
    uh(:,1) = y0;
    iter_pf=zeros(1,N);
    nmax=1000;
    toll=1e-5;
    for n=1:(N-1) % per ogni componente del vettore
        err=toll+1;
        k=0;
        phi=@(u) uh(:,n)+h*f(th(n+1),u);
        k0=uh(:,n);
        while(err>toll && k<nmax)
            k1=phi(k0);
            err=norm(k1-k0);
            k=k+1;
            k0=k1;
        end
        iter_pf(n+1)=k;
        uh(:,n+1)=k1;
    end
end

