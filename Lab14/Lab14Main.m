%% Esercizio 1
clc
clear all
close all
% a)
F=@(X) [X(1).^2-4*X(2).^2+3 ; X(1)-X(2).^2];
plotzeros(F,[-5 5],[-5 5])
% b) c)
x0=[0, -0.5]'; % x0=[3, 2]' x0=[3,-2]' trovo le altre
nmax=1000;
tol=1e-15; % questo è 10^(-15)
J=@(X) [2*X(1), -8*X(2) ; 1, -2*X(2)]; % virgola o spazio per separare
[x,it]=newtonsys(x0,nmax,tol,F,J)

%% Esercizio 2
clc
clear all
close all
% S suscettibili Z zombie R recovered 
% simulazione invasione zombie
% Modelli compartimentali
alfa=4; beta=1; zeta= 0.2;
Y0=[0.99 0.01 0]';
F=@(t,Y) [-beta*Y(1).*Y(2); (beta-alfa)*Y(1).*Y(2)+zeta*Y(3);alfa*Y(1).*Y(2)-zeta*Y(3) ];
t_0=0;
t_max=96;
h=0.1;
[th,uh,iter_pf]=eulero_indietrofake(F,t_0,t_max,Y0,h)
% uh sarà una matrice: 
% per ogni riga rappresenta una delle soluzioni di stato
% ad ogni colonna il valore che sta assumendo in quello stato
plot(th,uh(1,:),th,uh(2,:),th,uh(3,:),'LineWidth',3)
legend('S','Z','R')