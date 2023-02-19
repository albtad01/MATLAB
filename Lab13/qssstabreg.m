function qssstabreg(a,b,xmi,xma,ymi,yma,xpti,ypti)
%
%   qssstabreg(a,b,xmi,xma,ymi,yma,xpti,ypti)
%             
%   Disegna la regione di assoluta stabilita' del metodo multistep
%   i cui coefficienti a(j) j=0,...p sono dati nel vettore colonna 
%   'a', mentre i b(j) j=-1,....,p sono dati nel vettore colonna 'b'.
%   La regione di assoluta stabilita' e' in ogni caso contrassegnata 
%   dal colore verde, mentre la regione complementare e'
%   contrassegnata dal colore rosso.
%
%   Parametri di ingresso
%    a,b               Coefficienti dello schema multistep 
%    xmi,xma,ymi,yma   Limiti in x e y del rettangolo dove 
%		               si vuole disegnare la reg. di ass. stab.
%    xpti,ypti         Numero di punti di discretizzazione del 
%		               rettangolo (almeno 10x10)

a=[-1;a];
   
xst=(xma-xmi)/(xpti-1);
yst=(yma-ymi)/(ypti-1);

xx=[xmi:xst:xma];
yy=[ymi:yst:yma];
[x y]=meshgrid(xx,yy);

r=zeros(size(x));
[m1 m2]=size(x);

for i=1:m1
for j=1:m2
    aa=-a-b*(x(i,j)+sqrt(-1)*y(i,j));
    r(i,j)=max(abs(roots(aa)));
end 
end

rmin=min(min(abs(r)));
if (rmin>1) 
   disp('Incondizionatamente instabile: nessun grafico verra'' prodotto')
   return
end

for i=1:m1
 for j=1:m2
   if r(i,j) < 1
     q(i,j)=r(i,j);
   else
     q(i,j)=2;
   end
 end
end

map=[0.5 1 0.6;1 0 0]; 
colormap(map); 
%p=surf(xx,yy,q);
%p=contour(xx,yy,q);
p=contour(xx,yy,q,[2 2]);
view(2)
