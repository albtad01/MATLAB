function [th,uh]=eulero_avanti(f,t_0,t_max,y0,h)
    % La funzione restituisce il vettore th degli istanti temporali discreti 
    % e il vettore uh dei valori della corrispondente soluzione approssimata.
    % L'indice del vettore in cui sono rappresentati th ed uh rappresenta l'
    % istante temporale a cui siamo.
    
    th=t_0:h:t_max; % t_h=t0+h*n intervalli equispaziati
    N=length(th); % Nh+1=N
    uh=zeros(N,1);
    uh(1)=y0;
    for n=2:N
        uh(n)=uh(n-1)+h*f(th(n-1),uh(n-1));
    end
end