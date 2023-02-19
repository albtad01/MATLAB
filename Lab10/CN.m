function [th, uh, iter_pf] = CN(f, t_0, t_max, y0, h)

% Risolve il problema di Cauchy 
%
% y'=f(y,t)
% y(0)=y_0
%
% utilizzando il metodo di Crank-Nicolson
% (CN) : u^(n+1)=u^n+h/2*(f^{n} + f^{n+1} )
%
% Input:
% -> f: function che descrive il problema di Cauchy 
%       (dichiarata ad esempio tramite inline o @). 
%       Deve ricevere in ingresso due argomenti: f=f(t,y)
% -> t_max: l'istante finale dell' intervallo temporale di soluzione 
%                 (l'istante iniziale e' t_0=0)
% -> y0 : il dato iniziale del problema di Cauchy
% -> h  : l'ampiezza del passo di discretizzazione temporale.
%
% Output:
% -> th: vettore degli istanti in cui si calcola la soluzione discreta
% -> uh: la soluzione discreta calcolata nei nodi temporali t_h

th = t_0:h:t_max;
N = length(th);
uh = zeros(1,N);
uh(1) = y0;

% parametri per le iterazioni di punto fisso
Nmax = 1000;
toll = 1e-9;
iter_pf = zeros(1,N);

for it = 2:N
    phi = @(u) uh(it-1) + h/2 * ( f( th(it-1), uh(it-1) )  + f( th(it), u ) );
    j = 0; err = toll+1;
    w0 = uh(it-1);
    while err>toll && j<Nmax    
        w1 = phi(w0);
        err = abs(w1-w0);
        j = j+1;
        w0 = w1;
    end
    iter_pf(it) = j;
    uh(it) = w1;
end

