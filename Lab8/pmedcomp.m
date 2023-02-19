function [I]= pmedcomp(a,b,N,fun)
% funzione che restituisce l'integrale approssimato attraverso la formula del punto medio composito (GdE=1)
% formula semplice: (b-a)^3*f((a+b)/2)
% a,b -> sono dei double, estremi di integrazione
% N   -> numero di sottointervalli
% fun -> function handle, la funzione integranda
% devo dividere [a,b] in N sottointervalli
% trovo il punto medio xM
% a|-*-|-*-|-*-|-*-|b
% l'ampiezza di ogni sottointervallo h=(b-a)/2

% METODO MIO
h=(b-a)/N;
xx=linspace(a,b,N+1); % se io voglio N sottointervalli ho bisogno di N+1 nodi
xk=[];
for i=1:N
    xk=[xk fun(xx(i)+xx(i+1))/2];
end
I=h*sum(xk);

% METODO PROF
% I0=(b-a)*f((a+b)/2) base*altezza nel punto medio
% quando lo faccio composito lo ripeto su ogni sottointervallo
%h=(b-a)/N;
%xM=a+h/2:h:b-h/2; % vettore che contiene i punti medi degli intervalli (composito)
% xM=[]; altrimenti (equivalente ma col ciclo for)
% for jj=0:N-1
%    xM=[xM a+h/2+jj*h]
% end
%fxM=fun(xM); % vettore che contiene la valutazione di f nei punti medi xM
%I=h*sum(fxM); % NON mi serve il ciclo for, posso usare il comando SUM