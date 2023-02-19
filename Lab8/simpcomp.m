function [I]= simpcomp(a,b,N,fun)
% funzione che restituisce l'approssimazione dell'integrale sfruttando la formula composita di Cavalieri-Simpson (GdE=3)
% formula semplice: (b-a)/6*[f(a)+4f((a+b)/2)+f(b))

% METODO MIO

h=(b-a)/N;
fxk=[];
xk=linspace(a,b,N+1);
for ii=1:N
    fxk=[fxk fun(xk(ii))+4*fun((xk(ii)+xk(ii+1))/2)+fun(xk(ii+1))];
end
I=h/6*sum(fxk);















% h=(b-a)/N;
% xx=linspace(a,b,N+1);
% xk=[];
% for i=1:N
%     xk=[xk (fun(xx(i))+4*fun((xx(i)+xx(i+1))/2)+fun(xx(i+1)))];
% end
% I=h/6*sum(xk);

% % METODO PROF
% % a|xL-xM-xR|xL-xM-xR|-*-|-*-|b
% 
% h=(b-a)/N;
% xL=a:h:b-h;
% xM=a+h/2:h:b-h/2;
% xR=a+h:h:b;
% 
% I=h/6*sum(fun(xL)+4*fun(xM)+fun(xR));
% 
% % in alternativa
% x=a:h/2:b;
% % a|-*-|-*-|-*-|-*-|b
% % il primo, l'ultimo, 2 volte i pari
% % I=h/6*(fun(x(1))+sum(2*fun(x(3:2:end-2))+4*fun(x(2:2:end-2))+fun(x(end)))
