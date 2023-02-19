function [I]=trapcomp(a,b,N,fun)
% funzione che restituisce l'integrale approssimato attraverso la formula del trapezio composito (GdE=1)
% formula semplice: (b-a)^3/2*(f(a)+f(b))

% METODO MIO
h=(b-a)/N; % il nuovo intervallo non è (b-a), ma h
xx=linspace(a,b,N+1); % nodi
fxk=[];
for i=1:N
    fxk=[fxk fun(xx(i))+fun(xx(i+1))];
end
I=h/2*sum(fxk);

% METODO PROF
% h = ( b - a ) / N;
% x = linspace(a, b, N+1); % vettore dei nodi di integrazione
% y = fun( x );
% I = h * ( 0.5 * y( 1 ) + sum( y( 2 : N ) ) + 0.5 * y( N + 1 ) );
