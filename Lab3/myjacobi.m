function [xn,iter]=myjacobi(A,b,x0,nmax,toll)
% Algoritmo parallelizzabile
% x0= partenza della mia funzione per arrivare ad xn
% nmax= iterazioni massime fattibili
% toll= la tolleranza per stoppare la ricerca della soluzione esatta
% CONTROLLI
% ...
% Cuore dell'algoritmo
n=length(b); % oppure n=size(A,2);
iter=0;
err=toll+1; % numero grande oppure toll+1
xk=x0;
xn=x0;
while iter<=nmax && err>toll % CRITERIO DEL RESIDUO
    % per ogni passo k (iterazione -> iter)
    for ii=1:n
        sommatoria=A(ii,[1:ii-1,ii+1:n])*xk([1:ii-1,ii+1:n]); % riga i-esima j≠i
        xn(ii)=(b(ii)-sommatoria)/A(ii,ii);
    end
    err=norm(b-A*xk)/norm(b);
    iter=iter+1;
    xk=xn;
end