function [x] = bksub(U,y)
    % CHECK #1: U triangolare superiore
    if (isequal(U,triu(U)) == 0) 
        error('U non è triangolare superiore');
    end
    % CHECK #2: U quadrata
    nrighe= size(U,1);
    ncolonne= size(U,2);
    if(nrighe~=ncolonne)
        error('U è rettangolare')
    end

    % finiti i controlli
    
    x=zeros(nrighe,1); % preparo il pc: preparati a un vettore colonna soluzione con nrighe
    x(nrighe)=y(nrighe)/U(nrighe,nrighe); % l'ultima incognita la definisco facile
    for ii=nrighe-1:-1:1 % vai all'indietro
        x(ii)=(y(ii)-U(ii,ii+1:nrighe)*x(ii+1:nrighe))/U(ii,ii);
    end
    
    % in C vanno bene i for, con matlab meglio evitare
end