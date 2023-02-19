clear all;
clc;
close all;

%% Esercizio 1
% a)
A=[10 -1 2 3 ; 1 10 -1 2; 2 3 20 -1; 3 2 1 20]
triu(A,1) % costruisce la triangolare superiore, togliendo la diag princ
triu(A,2) % costruisce la triangolare superiore, togliendo la diag princ e quella sopra
xex=ones(4,1); 

% 1) A DDSR -> J e GS convergono
sum(abs(A),2); % fa la somma di ciascuna colonna di A in valore assoluto
sum(abs(A),2)-diag(abs(A)); % così faccio la somma di tutti i termini tranne di quelli sulla diagonale
if(sum(abs(A),2)-diag(abs(A))<diag(abs(A))) % input sensato anche se ho un vettore di 1
    disp('J e GS convergono: A DDSR')
else
    disp('prima cond non verificata')
end
% 2) A SDP -> GS converge
if(isequal(A,A')==1 & (eig(a)>0)==1)
    disp('GS converge')
else
    disp('seconda cond non verificata')
end
% Non vale la condizione sufficiente per la convergenza di GS, però tanto
% sappiamo che converge per il primo criterio
% 3) A tridiagonale -> J e GS convergono o divergono entrambi
% A non tridiagonale
% b)
% Matrice di iterazione BJ: Splitting
% Definisco le mie 3 matrici D -E=E -F=F
A
D=diag(diag(A));
E=-tril(A,-1) % escludo una diagonale (la principale): -1 per la tril
F=-triu(A,1) % 1 per la triu
% è una costruzione coerente: -E=tril... come da definizione (idem -F)
% quindi -E rappresenta gli effettivi elementi sulla diagonale inferiore
% cambiati di segno

% BJ: D*BJ=(-E-F) risolvo il sistema
BJ= D\(E+F) % altrimenti inv(D)*(E+F) -> modo furbo BJ=diag(1./diag(A))*(E+F)
% BGS: (D-E)*BJ=(-F) risolvo il sistema
BGS= (D-E)\F
NBJ=norm(BJ)

% trovo i due raggi di convergenza rho (più piccoli sono meglio è):
% rho è l'autovalore massimo in valore assoluto
rhoBJ=max(abs(eig(BJ)))
rhoBGS=max(abs(eig(BGS)))
% rho BGS < rho BJ
% il raggio di jacobi è più grande di quello di gauss-seidel
ep=1e-10;
kmin=log10(ep)/log10(norm(BJ)) % vedi appunti 17/03; log qualsiasi base
kminc=ceil(kmin) % ceil approssima al successivo
% c) 
% Fatta la versione scalare: formula
A=[10 -1 2 3 ; 1 10 -1 2; 2 3 20 -1; 3 2 1 20]
c=A(2,[1:2-1,2+1:4]); % salto la colonna della diagonale, ossia A(2,2)
%A(ii,[1:ii-1,ii+1:n]); % equivale riga i-esima però colonna j≠i (no l'elemento su diag)
xex=ones(4,1);
b=A*xex;
x0=zeros(4,1);
nmax=26 % se metto numero più basso faccio meno tentativi: verrà lontano da vettore di 1
toll=1e-10
[xn,iter]=myjacobi(A,b,x0,nmax,toll) % criterio del residuo
norm(xex-xn)./(xex-x0)

%% e) Homework
A=[10 -1 2 3 ; 1 10 -1 2; 2 3 20 -1; 3 2 1 20]
xex=ones(4,1);
b=A*xex;
x0=zeros(4,1);
nmax=26;
toll=1e-10;
w=1;
[xn,iter]=mysor_prof(A,b,x0,nmax,toll,w)
% Sì: l'errore relativo vale 1.9243e-11, che è minore di 1e-10