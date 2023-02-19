function [y] = fwsub(L,b) % risolve Ly=b
    % CHECK #1: Triangolare Inferiore
    if (isequal(L,tril(L)) == 0) 
        error('L non è triangolare inferiore'); % quando c'è un errore la funzione si chiude e dà messaggio errore.
    end
    %CHECK #2: Quadrata
    nrighe= size(L,1);
    ncolonne= size(L,2);
    if(nrighe~=ncolonne)
        error('L è rettangolare')
    end

    % arrivati qui finiti i controlli

    y=zeros(nrighe,1); % preparo il pc: preparati a un vettore colonna con nrighe
    y(1)=b(1)/L(1,1);
    for ii=2:nrighe % per tutte le altre righe...
        y(ii) = (b(ii) - L(ii, 1: ii -1) * y (1:ii-1)) / L(ii,ii); % nella parte centrale è il prodotto tra vettori coefficienti e incognite
    end

    % in C vanno bene i for, con matlab meglio evitare

end