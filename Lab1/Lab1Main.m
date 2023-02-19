clc;
clear all;
close all;

%% ESERCIZIO 1

A=[50 1 3; 1 6 0; 3 0 1];
B=[50 1 10; 3 20 1; 10 4 70];
C=[7 8 9; 5 4 3 ; 1 2 6];
FlopsA=NumeroFlopsCramer(A)

% a)
% Condizioni sufficienti: SDP oppure DDSR/DDSC
% Condizioni necessarie e sufficienti: determinante sottomatrici principali diverso da 0

% A SDP: Simmetrica definita positiva [Suff1]?
isequal(A,A'); % se A simmetrica restituisce 1
if(isequal(A,A')==1)
    disp('A simmetrica');
end
if(eig(A)>0) % eig restituisce gli autovalori; controlla che tutti gli elementi dentro eig siano >0
    disp('A definita positiva');
end
if(eig(A)>0 & isequal(A,A')==1)
    disp('A è SDP')
end

% B DDSR o DDSC [Suff2]?
B
diagonaleB=diag(abs(B)) % elementi della diagonale di B presi in val. ass.
sommacolonne=sum(abs(B),1) % somma per colonne
sommarighe=sum(abs(B),2) % somma per righe
% DDSR
% diagonaleB > (sommarighe-diagonaleB): devo escludere gli elementi della diagonale dalla somma 
if(diagonaleB - (sommarighe - diagonaleB) > 0)
    disp('B dominanza stretta per righe (DDSR)');
end
% diagonaleB> (sommacolonne'-diagonaleB): devo escludere gli elementi della diagonale dalla somma
sommacolonne'-diagonaleB % ora va bene: l'ho trasposto '
if(diagonaleB - (sommacolonne'-diagonaleB) > 0)
    disp('B dominanza stretta per colonne (DDSC)')
end

% C determinante delle sottomat~=0 [NeccSuff]?
n=size(C,1)
cns=1;
for ii= 1 : n
        if (det(C(1:ii,1:ii))==0) % prendiamo ogni iterazione una sottomatrice crescente (principale)
            cns=0; % variabile flag
            break;
        end
end
cns
if(cns==1)
    disp('Condizione necessaria verificata');
else
    disp('Condizione necessaria NON verificata');
end
% parto dalla sottomatrice 1 e via via mi allargo: C(1:ii,1:ii) identifica
% la sottomatrice che si estende da i=1 a ii per la riga e idem nella
% colonna, dove ii evolve ad ogni iterazione del ciclo

%% b)
% help lu
% [L,U] se pivoting l'esito della L e U già applicate e modificate come pivoting
% usiamo sempre [L,U,P], più comodo
[L,U,P]=lu(A) % P matrice permutazioni fatte; LU=PA -> PAx=Pb
[L,U]=lu(A)
I=eye(3);
if(P==I)
    disp('no permutazione')
end
% P è uguale all'identità quindi non viene applicato pivoting

A=[1 0 0; 0 1 0; 0 0 1]
Asparsa = sparse(A) % mi dice soltanto gli elementi diversi da 0 nella loro posizione in cui sono salvati
Aintera = full(Asparsa) % dandogli la posizione degli elementi diversi da 0 ti costruisce la matrice

[LA, UA, PA]= lu(A)
[LB, UB, PB]= lu(B)
[LC, UC, PC]= lu(C)
% tutte le P=I, infatti prima avevo che tutte verificavano la fattorizzazione LU
% Se verificano la fattorizzazione LU, allora P=I

%% c)
% Adesso partiamo dalle matrici U e L per trovare la nostra soluzione x:

% A*x=b  P*A=L*U
% P*A*x=P*b
% L*U*x=P*b

% L*y=P*b -> sostituzioni in avanti -> L fwsub.m forward substitution
% fwsub(L,b) mi restituisce la y
% U*x=y -> sostituzioni all'indietro -> U bwsub.m backwards substiution
% bksub(U,b) mi restituisce la x
G=[2 3 0; 4 5 6; 8 6 2];
h=[1;3;4];
l=G\h
[L,U,P]=lu(G)
y=fwsub(L,P*h)
x=mybksub(U,y)

%% d)
A=[50 1 3; 1 6 0; 3 0 1];
xex=[1;1;1];
A
b=A*xex;
[L,U,P]=lu(A) 
% in questo caso P=I, ma in generale PAx=Pb -> LUx=Pb, applichiamolo così:
y=fwsub(L,P*b) % Ly=Pb
x=bksub(U,y) % Ux=y

%% ESERCIZIO 2
B=bucky;
figure;
spy(B), title('B')
% spy fa vedere quanto è sparsa la matrice
G = graph(bucky);
figure;
p = plot(G)
[i,j] = find(B);
bw = max(abs(i-j)) +1
[L,U,P] = lu(B)
subplot(2,2,1), spy(L), title('L')
subplot(2,2,2), spy(U), title('U')
subplot(2,2,[3 4]), spy(P), title('P')
%% ESERCIZIO 3
% directory FEM4MI