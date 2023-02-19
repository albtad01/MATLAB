function [th,uh]=eulero_avantiab(a,b,t_0,t_max,y0,h)
    % La funzione restituisce il vettore th degli istanti temporali discreti 
    % e il vettore uh dei valori della corrispondente soluzione approssimata.
    % L'indice del vettore in cui sono rappresentati th ed uh rappresenta l'
    % istante temporale a cui siamo.
    
    % ricordo: f(t,y)=a(t)y+b(t)
    th=t_0:h:t_max; % t_h=t0+h*n intervalli equispaziati
    N=length(th); % Nh+1=N
    uh=zeros(N,1);
    uh(1)=y0;
    for n=2:N
        uh(n)=uh(n-1)+h*(a(th(n-1))*uh(n-1)+b(th(n-1)));
    end
end