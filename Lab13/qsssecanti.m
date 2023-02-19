function [xvect,xdif,fx,it]=qsssecanti(x0,x1,nmax,toll,fun)
%
%  [xvect,xdif,fx,it]=qsssecanti(x0,x1,nmax,toll,fun)
%    
%  Metodo delle secanti per la ricerca degli zeri della 
%  funzione fun. Test d'arresto basato sul controllo
%  della differenza tra due iterate successive.
%
%  Parametri di ingresso:
%
%  x0        Primo punto di partenza
%  x1        Secondo punto di partenza
%  nmax      Numero massimo di iterazioni
%  toll      Tolleranza sul test d'arresto
%  fun       Macro contenente la funzione
%
%  Parametri di uscita:
%
%  xvect     Vett. contenente tutte le iterate calcolate
%            (length=it+2, l'ultima componente e' la soluzione)
%  xdif      Vett. contenente l'avanzamento tra due iterate
%  fx        Vett. contenente le valutazioni di 'fun' in 'xvect'
%  it        Iterazioni effettuate
%
err=1;
it=0;
fx0=fun(x0);
fx1=fun(x1);
xvect=[x0;x1];
fx=[fx0;fx1];
xdif=abs(x1-x0);
%
while it<nmax & err>toll
   x=x1-fx1*(x1-x0)/(fx1-fx0);
   fxn=fun(x);
   xvect=[xvect;x];
   fx=[fx;fxn];
   err=abs(x1-x);
   xdif=[xdif;err];
   it=it+1;
   x0=x1;
   fx0=fx1;
   x1=x;
   fx1=fxn;
end
%
dim=max(size(xvect)); 
fprintf(' \n Numero di Iterazioni : %d \n',it);
fprintf(' Radice calcolata     : %12.8f \n',xvect(dim));
%
return
