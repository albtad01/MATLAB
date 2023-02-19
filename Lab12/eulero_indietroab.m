function [th,uh]=eulero_indietroab(a,b,t_0,t_max,y0,h)
    % La funzione eulero_indietro riceve in ingresso a(t) e b(t) e restituisce 
    % il vettore th degli istanti temporali discreti e il vettore uh dei valori 
    % della corrispondente soluzione approssimata.
    
    th=t_0:h:t_max;
    N=length(th); % oppure size(th,2) (2 perché vettore riga)
    uh=zeros(N,1);
    uh(1)=y0;
    for n=2:N
        % uh(n)=uh(n-1)+h*f(th(n),uh(n))
        % ma non posso farlo perché non ho definito uh(n)
        uh(n)=(uh(n-1)+h*b(th(n)))/(1-h*a(th(n)));
    end
end