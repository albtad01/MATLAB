%% ESERCIZIO 1
clc
clear all
close all
% a)
f=@(x) (cos(x-1)).^2-x.^2;
xx=linspace(0,2.7,500);
plot(xx,f(xx),'LineWidth',2);
grid on;
% Esiste ed è unico lo zero: la radice è 1 ed ha molteplicità 1:
alpha=1 % taylor(alpha) 
% / la derivata (monotona) f'(alpha)!=0;
% è strettamente decrescente nell'intervallo
% b) e c)
err=[];
errVect=[];
for x0=[0.3 0.6 1.2] % varie partenze
    [xvect,niter]=corde(0,2.7,x0,1000,1e-10,f);
    errVect=[errVect abs(xvect(end)-alpha)];
    semilogy(0:niter,abs(xvect-alpha),'LineWidth',2);
    hold on;
    title('Errore xvect-alpha al variare del numero di iterazioni');
    [p,c]=qssstimap(xvect);
end
legend('x0=0.3','x0=0.6','x0=1.2');

% errVect
% semilogy(errVect) % non ha senso

% per i tre x0 iniziali vediamo come scala l'errore:
% sta scalando linearmente (sono paralleli)
% variazione del guess iniziale: non sono globali ma locali
% a seconda del dato iniziale ci mette più o meno tempo: 1.2
% è il più veloce perché è molto vicino ad 1

%% ESERCIZIO 2
clc
clear all
close all
a=0.5; b=2;
xx=linspace(a,b,1000);
% a)
f= @(x) log(x); % radice in 1 -> m=1
df= @(x) 1./x;
g= @(x) 1-x+log(x); % radice in 1 -> m=2 (sviluppo o derivata) % g converge quadraticamente newton normale radice a=1 f(a) e f'(a) = 0)
dg= @(x) -1+1./x;

plot(xx,f(xx),xx,df(xx),'LineWidth',2);
legend('f','derivata f');
figure;
plot(xx,g(xx),xx,dg(xx),'LineWidth',2);
legend('g','derivata g');

% b) e c)

% 1) f(x)
% sceglierò un x0 "vicino" ad 1 (capire il guess iniziale non facile) -> ricerca
figure
x0=0.9; % o 0.7 ...
nmax=100;
toll=1e-6;
mol=1;
alpha=1;
[x_vect,it] = newton(x0,nmax,toll,f,df,mol); % molteplicità per f è 1 (conv. quadratica)
err=abs(x_vect-alpha);
semilogy([0:it],err,'LineWidth',2);
xlabel('Numero Iterate');
ylabel('Errore');
% 2) g(x)
[x_vect,it]=newton(x0,nmax,toll,g,dg,mol);
err=abs(x_vect-alpha);
figure;
semilogy([0:it],err,'LineWidth',2);
hold on;
mol=2;
[x_vect,it]=newton(x0,nmax,toll,g,dg,mol);
err=abs(x_vect-alpha);
semilogy([0:it],err,'LineWidth',2);
legend('Newton','Newton Modificato');
xlabel('Iterazioni');
ylabel('Errore');

%% ESERCIZIO 3
clc
clear all
close all
format short
% syms x y1 y2;
% y1=(x^2+6)/5;
% y2=(sqrt(5*x-6));
% dy1=diff(y1);
% dy2=diff(y2);
tol=1e-10;
phi=@(x) (x.^2+6)/5; % questo converge a 2
%phi=@(x) sqrt(5*x-6); % questo converge a 3
kmax=1000;
for x0=[1.5 2.5 2.98 3.1]
    [xvect, niter] = punto_fisso( phi, x0, tol, kmax )
end

%% ESERCIZIO 4
clc
clear all
close all
f=@(x) x.^3-x.^2+8*x-8;
xx=linspace(-100,100,500);
plot(xx,f(xx),'LineWidth',2)

% fzero(f,2) trova gli zeri della funzione f
% tablet