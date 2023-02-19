function [xn,iter,err] = mygs(A,b,x0,w,nmax,toll)
% Attenzione: Algoritmo non parallelizzabile
% CONTROLLI
if(size(A,1)~=size(A,2))
    error('MATRICE RETTANGOLARE')
end
% Cuore dell'algoritmo
iter=0;
err=toll+1;
n=size(A,1);
xk=x0; % vettore iterazione k (inizializzato ad x0)
xn=x0; % vettore iterazione k+1 (inizializzato ad x0)
while iter<nmax & err>toll
    for ii=1:n
        sommsx=A(ii,[1:ii-1])*xn([1:ii-1]); % fino i-1 considero le componenti del vettore k+1 nuovo
        sommdx=A(ii,[ii+1:n])*xk([ii+1:n]); % da i+1 considero le componenti del vettore k vecchio
        xn(ii)=w/A(ii,ii)*(b(ii)-sommsx-sommdx)+(1-w)*xk(ii);
    end
    err=norm(b-A*xn)/norm(b); % residuo normalizzato, che dovrò confrontare con la tolleranza
    xk=xn;
    iter=iter+1;
end