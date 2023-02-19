clear all;
close all;
clc;
%% Esercizio 1
%% a)
% Creo una matrice di Hilbert A per ogni n e memorizzo ciascun numero di condizionamento dentro un vettore
K2A=zeros(10,1);
for n=1:10
    A=hilb(n) 
    K2A(n)=cond(A) % numero di condizionamento 2 (altrimenti specificare cond(A,num)
end
%% b)
% x,y con y grafico del risultato con logaritmo applicato

semilogy([1:10],K2A([1:10]),'LineWidth',2)
xlabel('n')
ylabel('andamento logaritmico K2')
% semilogy mostra andamento lineare nelle x ed esprime le y in forma logaritmica (base 10)
% loglog mostra forma logaritmica sia x che y
% retta in grafico logaritmico = esponenziale
%% c)
residuo_norm=zeros(10,1);
for n=1:10
    A=hilb(n);
    xex=ones(n,1);
    b=A*xex;
    x=A\b;
    K2A(n)=cond(A);
    er(n)=norm(x-xex)/norm(xex);
    residuo_norm(n)=norm(b-A*x) / norm(b);
end

er'
figure
semilogy([1:10],K2A,'LineWidth',3)
hold on
semilogy([1:10],er,'LineWidth',3)

semilogy([1:10]',residuo_norm,'LineWidth',3)
semilogy([1:10]',K2A.*residuo_norm,'LineWidth',3)
legend('K2','er','residuo norm','stima')
grid on
xlabel('n')
% possiamo vedere che il teorema di stabilità viene verificato 

%% QUIZ
A=hilb(10);
autovalori=eig(A);
max(autovalori)
min(autovalori)
%% Esercizio 2
% a)
% A simmetrica definita positiva
% condizionamento in norma 2 = condizionamento spettrale
% = AutoValMax/AutoValMin
A=[1001 1000; 1000 1001]
autA=eig(A)
K2A=cond(A)
K2AA=norm(A)*norm(inv(A)) % definizione di numero di condizionamento (K2AA=K2A)
K2AAlternativo=max(autA)/min(autA)
% per flussi di informazioni con conti diversi
toll=1e-10
if(abs(K2A-K2AAlternativo)<toll)
    disp('Approssimazione buona')
end
% sono uguali per il teorema
%% b)
b=[2001 2001]';
xex=[1;1];
xnum=A\b
delta_B=[1 0]'
xnum_pert=A\(b+delta_B) % grande variazione
% piccola perturbazione -> grande cambiamento nella soluzione (condizionamento alto)

%% c)
b=[2001 -2001]'
x=A\b
delta_b=[1 0]'
xnew=A\(b+delta_b) % nonostante la perturbazione, tra x ed xex cambia poco

%% d)
x=[2001 -2001]'
dx=[1 0]'
b=A*x
btilde=A*(x+dx)
% La perturbazione sulla soluzione viene amplificata nel calcolo del termine noto

%% QUIZ
% b)
