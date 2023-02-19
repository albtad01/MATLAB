function [th,uh]=heun(f,t_0,t_max,y0,h)
    th=t_0:h:t_max;
    N=length(th);
    uh=zeros(N,1);
    uh(1)=y0;
    for n=2:N
        uh(n)=uh(n-1)+h/2*(f(th(n-1),uh(n-1))+f(th(n),uh(n-1)+h*f(th(n-1),uh(n-1))));
    end
    % Qui siamo fortunati perché H, a differenza di EI, è un metodo ESPLICITO, quindi 
    % non devo risolvere un'equazione.
    % Altrimenti avrei dovuto linearizzare oppure risolverla coi metodi studiati EQNL.
end