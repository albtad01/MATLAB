clc;
clear all;
close all;
%% Esercizio 1

A=[4.24 -4.32; -4.2 6.76]
b=[4;8]
% creo il dominio per plottare la forma quadratica: è una griglia che contiene 
% per ogni punto la prima e la seconda componente
x1=linspace(-10,10,100);
x2=linspace(-10,10,100);
[X,Y]=meshgrid(x1,x2); % meshgrid crea tutti i prodotti cartesiani
% lo risolvo a mano (minimo della psi(x) va a trovare la soluzione esatta x del sistema)
Phi = 1/2*(A(1,1)*X.^2+A(2,2)*Y.^2+2*A(1,2)*X.*Y)-b(1)*X-b(2)*Y;
size(Phi)
surf(X,Y,Phi,'Lines','no'); % plotta l'estensione lungo la verticale
figure
contour(X,Y,Phi,20); % Linee di livello: lo affetta in 20 parti
%% a)
alpha=0.05;
tol=1e-7;
nmax=1000;
x0=[-9;-9];
P=eye(2);
[xk,kr]=richardson(A,b,P,x0,tol,nmax,alpha)
size(xk) % 2x332
contour(X,Y,Phi,20);
hold on;
plot(xk(1,:),xk(2,:),'r-*','LineWidth',2);
%% b)
P=[1.0912 -0.8587 ; -0.8587 1.5921]
[xk,kg]=gradiente(A,b,P,x0,tol,nmax)
contour(X,Y,Phi,20);
hold on;
plot(xk(1,:),xk(2,:),'r-*','LineWidth',2);
kr
kg
% Gradiente ci mette molto meno di richardson stazionario
% tutte le direzioni perpendicolari -> ortogonali nel cambio di base
% c) Non è sdp: manca la prima delle due ipotesi per P-1*A
%% Esercizio 2
A = delsq( numgrid('B',50) );
b = ones( size(A,1),1 );

figure
spy(A)
% A R^(n x n) -> cg converge in al più n iterazioni in ARITMETICA ESATTA
% n=1814
% ovviamente A sdp
tol= 1e-12;
nmax=1000;
P=eye(size(A,1));
[X,FLAG,RELRES,ITER,RESVEC]=pcg(A,b,tol,nmax,P)
