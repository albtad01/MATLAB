clc; % cancella istruzioni a schermo
clear all; % cancella tutte le variabili
% ogni volta che metti %% il compilatore svolge solo da quando metti %% 

%% ANALISI 1: CALCOLO SIMBOLICO
syms x y; %dichiaro x ed y come variabili simboliche

y=(x+0.1)*sqrt(abs(x+0.1))
dy=diff(y) % derivazione
iy=int(y,0,1) % integrale definito da 0 a 1
double(iy) % passaggio da var. simbolica a double

%% OPERAZIONI VETTORI
i 
j % unità immaginarie: non usarle come variabili
% buona norma inserirli all' inizio di ogni codice
d=[1:4] % crea un vettore con valori da 1 a 4 (per scontato passo 1)
e=[1:2:7] % crea un vettore con valori da 1 a 7, ma con passo 2 [1 3 5 7]
f=[7:-2:1] % passa da 7 a 1 in countdown con passo 2
g=linspace(1,7,4) % equivalente ad e perché dire che deve arrivare da 1 a 7 con passo 2 equivale a dire che deve avere 4 elementi da 1 a 7
h=[1;2;3] % col ; vai a capo, quindi questo è un vettore colonna
g=h' % ' = trasposto
% con + - * / attenzione perché si fanno sempre operazioni tra matrici
k = [ 1 2 3 ; 2 4 6 ; 3 6 9 ]
k+3 % (*eye(3)) aggiunge 3 a TUTTI gli elementi della matrice
b = [2 5 3 2]
c = [1 2 4 2]
% b*c non si può fare perché abbiamo 4x1 * 4x1 INCOMPATIBILE
l=b.*c % col .(operazione) facciamo l'operazione per ciascuna componente ij (operazione) ij
% in questo caso noi moltiplichiamo la componente 11 per la componente 11..
% l=[2    10    12     4]
% IMPORTANTE: b e c stesse dimensioni, sia che siano vett/matr
% . ELEMENTO PER ELEMENTO , (no.) OPERAZIONE MATRICIALE "CLASSICA"

%% OPERAZIONI MATRICI
K=k
size(K,1) % dimensione righe
size(K,2) % dimensione colonne
size(K) % dimensione matrice (dice sia righe che colonne)
max(K) 
min(K) 
sum(K) % restituiscono vettore riga con l'elemento più ... per ogni colonna
sum(K,1) % restituisce riga con somma delle colonne
sum(K,2) % restituisce un vettore colonna con somma delle righe
diag(K) % restituisce la diagonale principale di K; se ha un vettore in input lo trasforma in una matrice aventi gli elementi del vettore sulla diagonale
diag(K,1) % restituisce la prima sopradiagonale di K
diag(K,-1) % restituisce la prima sottodiagonale di K
tril(K) % triLower crea matrice triangolare inferiore
triu(K) % triUpper crea matrice triangolare superiore
K(1,1) % estrae elemento in posizione (1,1)
K(:,1) % tutti gli elementi della colonna 1
K(1,:) % tutti gli elementi della riga 1
K([1,3],1) % estrae riga 1 e 3 della colonna 1
K(1:3,1) % estrae dalla riga 1 alla riga 3 della colonna 1
norm(e) % norma euclidea di e
zeros(4) % costruisce una matrice 4x4 piena di 0
ones(4) % costruisce una matrice 4x4 piena di 1
ones(4,3) % costruisce una matrice 4x3 piena di 1
eye(4) % costruisce la matrice identità 4x4
tic
rand(5,2) % costruisce matrice con valori random 5x2
f=toc
% se metto tic prima di una procedura e poi var=toc dopo procedura, var mi
% indica tempo di esecuzione della procedura
det(K) % determinante di K
rank(K) % rango di K
eig(K) % trova gli autovalori di K
A=[1 2 ; 0 3]
b=zeros(2,1)
b=[1; 2]
x=A\b % risolve il sistema lineare con algoritmo efficiente

%% FUNZIONI

% ANONYMOUS FUNCTION
% SINTASSI: [NomeFunzione]= @([VariabiliInput]) [ContenutoFunzione]
cubica= @(x) x.^3
cubica(2)
cubica(2:5)
% EVAL FUNCTION
% SINTASSI: [NomeFunzione]=eval('[ContenutoFunzione]') e incognita: linspace
input=linspace(0,2*pi,100);
f=eval('input.*sin(input)');
% f contiene vettore con 100 valori, risultato della funzione
plot(input,f) 
% eval function uguali alle anonymous ma nostre librerie usano eval

% FUNZIONE SU FILE .m
R=[2 2; 8 4] % matrice 2x2
Determinante2x2(R) % rimando alla funzione che ho scritto nel file Determinante2x2.m
H=[2 2 2; 2 2 2]
Determinante2x2(H)

%% Visualizzazione testo
disp('come stai?') % stampa questo messaggio
d=4
% se voglio mettere insieme più variabili con stringhe
fprintf("La variabile d vale %d\n",d)

%% INTERVALLI
x=[0:0.1:3] % crea valori da 0 a 3 intervallati da 0.1
y=linspace(5,10,4) % crea un vettore di 4 elementi tra 5 e 10 (default linspace(5,10) aggiunge 100
% : lavora con passo definito in mezzo 
% linspace lavora con numero elementi definito in fondo

%% Grafici PLOT
 % apre una nuova figura (va messo prima del plot quando si bugga)
x=[0:0.1:3]; % vettore che va da 1 a 3 con passo 0.1
cubicag= @(x) x.^3
plot(x,cubicag(x),'c'); % plot(X1,Y1,S1,X2,Y2,S2,X3,Y3,S3,...) mette X1 sulle ascisse e Y1 sulle ordinate con le condizioni della stringa S1, poi X2,Y2,S2...
hold on % il successivo plot che ho si SOVRASCRIVE AL PRECEDENTE
quadraticag= @(x) x.^2
plot(x,quadraticag(x),'r')
% loglog=plot
grid on % mette la griglia
title('Cubica vs Quadratica') % Titolo
xlabel('Valori della x') % Scritta sulla x
ylabel('Valori della y') % Scritta sulla y
legend('cubica','quadratica','Location','NorthEast') % legenda: primo val è primo grafico che ho messo, ..., poi location gli dici dove inserirla
hold on
quadraticagh= @(x) x.^4;
cubicagh= @(x) x.^5;
plot(x,cubicagh(x),'b',x,quadraticagh(x),'y')
% blu>giallo>ciano>rosso 5>4>3>2
%% Cicli FOR/WHILE
% Vedi Informatica A

%% IF
% ~ NOT LOGICO (help not)
% & AND LOGICO non serve il doppio &&
% | OR LOGICO non serve il doppio ||
if(d>=4)
    disp('ok')
else 
    disp('no')
end
eps % valore più piccolo assumibile da matlab
1+eps % si accorge che c'è qualcosa e lo stampa con virgola tanti 0
1+eps/2 % non si accorge di qualcos altro e quindi stampa solo 1
%% PROVE
%% Differenza punto / Senza punto
g=@(x) x^2 + x^4
g(2)
A=[1 1 ; 1 1]
g(A)
%%
B=[1/10 0 ; -1 19/30]
norm(B,inf)
((19/30)*10^-2)/abs(((19/30)-1))
%% n=50;
vet4=4*ones(1,n)
vet1=-1*ones(1,n-1)
vet11=-1*ones(1,n-2)
A=diag(vet4)+diag(vet1,1)+diag(vet1,-1)+diag(vet11,-2)+diag(vet11,2)
%% Esponenziale
exp(0)
% non si usa e^..., bisogna usare exp(...) con argomento l'esponente
%% LogLog
xx=[1 5 10 0]
yy=[6 5 10 99]
plot(xx,yy)
figure(2)
loglog(xx,yy)