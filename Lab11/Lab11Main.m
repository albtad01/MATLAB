
% matteo1.salvador@polimi.it = mail vera


%% ESERCIZIO 1 
clc
clear all
close all
% Definiamo il piano complesso
ReZ=linspace(-3,3,101);
ImZ=linspace(-3,3,101);
[a,b]=meshgrid(ReZ,ImZ);
Z=a+i*b;
% Definiamo g(z)
g=@(z) abs(1+z+1/2*z.^2); % EA
titolo='Eulero avanti'
% valutiamo g in Z e ne prendiamo il modulo
% Rappresentiamo la regione di assoluta stabilita' contourf(a,b,gZ_mod,[0 1])
hold on
gZ=g(Z)
contourf(a,b,gZ,[0 1])
grid on
axis([-3 3 -3 3])
axis square
xlabel('Re(h\lambda)')
ylabel('Im(h\lambda)')
title('H')
colormap('summer')
%% Per gli altri metodi:
% Sostituire alla riga 27
% EE: |1+z|<1
% EI: |1/(1-z)|<1
% CN: |(2+z)/(2-z)|<1
% H: |1+z+z^2/2|<1

%% ESERCIZIO 1: Spiegazione supplementare
clc
clear all
close all

% uh(n+1) = (1+hlambda) u(n)

% Gtilde: R^2 -> R
% Gtilde: (parto da un num compl. R^2 e valuto il modulo R)
% creo il dominio per plottare la forma quadratica: è una griglia che contiene 
% per ogni punto la prima e la seconda componente

ReZ=linspace(-5,5,101);
ImZ=linspace(-5,5,101);
[A,B]=meshgrid(ReZ,ImZ)

% A,B rappresenteranno le coordinate in una griglia
% B=A'

% R^2 -> R perché parliamo di rappresentazioni di superfici

% Rappresentiamo il numero complesso z=h*lambda;
% l'importante è rappresentare la regione (è un num compl.)

Z=A+i*B; % così rappresento tutte le combinazioni per il num compl. (RETICOLO NUM. COMPL.)
g=@(z) 1+z;
Gtilde=abs(g(Z)); % Gtilde è la funzione che verifica l'ass.stab.

%% Rappresentazione 1: MESH
mesh(A,B,Gtilde)
colorbar % colore proporzionale all'altezza
%% Rappresentazione 2: CONTOURF
figure
contourf(A,B,Gtilde,[0:1]) 
% in viola (0) regione di assoluta stabilità (soddisfatta la condizione |...|<1)
% in giallo (1) fuori regione di assoluta stabilità (NON soddisfatta la condizione |...|<1)
axis square
grid on
colorbar
%% Rappresentazione 3: MESH con Identificatore
ID=Gtilde<1; % whose ID
M=ID.*Gtilde
mesh(A,B,M)
view(2) % per vederlo in 2D
surf(A,B,M)
axis square

%% ESERCIZIO 2
clc
clear all
close all
% a)
% lambda=10>0 impossibile perché altrimenti l'esponenziale diverge: lambda negativo così va a zero
t_0=0;
t_max=1;
y0=2;
lambda=-42;
tt=linspace(t_0,t_max,1000);
y=@(t) y0*exp(lambda*t);
plot(tt,y(tt),'LineWidth',2);
% b)
f=@(t,y) lambda*y;
for h=[0.05 0.0286 0.0167]
    [th_EA,uh_EA]=eulero_avanti(f,t_0,t_max,y0,h)
    hold on
    plot(th_EA,uh_EA,'LineWidth',2);
end
legend('y esatta','EA h=0.5','EA h=0.0286','EA h=0.0167')
% più andiamo piccoli, più si avvicina alla soluzione

%% ESERCIZIO 3
clc 
clear all
close all
eps=1e-2;
h1=0.1;
% h2=0.05;
f=@(t,y) -y+exp(-t);
[th_H,uh_H]=heun(f,0,3,0,h1);
g=@(t,z) -z+exp(-t)+eps*exp(-t);
[th_Hper,zh_H]=heun(g,0,3,eps,h1);
C=norm(zh_H-uh_H,inf)/eps

%% ESERCIZIO 4
clc
clear all
close all
eps=0.1;
t_0=0;
t_max=3;
h=0.1;
f=@(t,y) y+0*t;
y0=1;
g=@(t,z) z+0*t;
z0=1+0.1;
[th_H,uh_H]=heun(f,t_0,t_max,y0,h);
[th_Hper,zh_H]=heun(g,t_0,t_max,z0,h);
plot(th_H,uh_H,th_Hper,zh_H,'LineWidth',2);
title('Confronto soluzione h=0.1 problema perturbato (zh) e non (uh)');
legend('uh','zh')
C=norm(uh_H-zh_H,inf)/eps