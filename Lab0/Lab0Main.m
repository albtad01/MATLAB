%% Lab0 intro matlab
clear all, close all, clc
%% Esercizio 1
% a)
M=[2 3 4
   3 4 5
   4 5 6];
% col ; non lo stampa
det(M)
% b)
% Costruire la matrice A di ordine n=10
% t.c. l'elemento aij sia la somma degli indici i+j.
n=10;
A=zeros(n); % zeros(n,n); buon uso per motivi prestazionali
% for
for i=1:n
    for j=1:n
        A(i,j)=i+j;
    end
end
A
% while
%while condizionelogica
    % istruzioni
%end

% if condizionelogica
    % istruzioni
% elseif condizione2 (se non è vero il primo if ed è vera la condizione in
% questo if... fa istruzioni2)
    % istruzioni 2
% else % istruzioni 3 (se non è vero né il primo if né il secondo elseif
% end (chiude l'if che avevi aperto prima)
% c)
A(5,3)
A(:,1) % prima colonna
A(3,:) % terza riga
diag(A) % se diamo una matrice dà vettore della diagonale, se gli diamo un vettore restituisce matrice con la diagonale con quel vettore
diag(A,1) % prima sopradiagonale
tril(A) % triangolare superiore
triu(A) % triangolare inferiore
B=A(:,[3 4 8]) % tutte le righe delle colonne 3,4,8
C=A([1 3 10],:) % tutte le colonne delle righe 1,3,10
% d)
n=15;
D=zeros(n); % matrice di zeri
I=eye(n); % matrice identità (1 sulla diagonale = I=diag(ones(1,n))
vettore2=2*ones(1,n-1); % vettore di 2 di dimensione n-1
D2=diag(vettore2,1) % costruisco matrice che ha 2 sulla prima sovradiagonale: dimensionalmente corretto
D=D+I+D2
D(:,1)=(1:n)'; % nella prima colonna mettigli un vettore che va da 1 a n.
D
%% Es2
n=15;
for ii=1:n
    for jj=1:n
        if(mod(ii+jj,2)==0)
            T(ii,jj)=1;
        else
            T(ii,jj)=0;
        end
    end
end
T
%% Es3
hilb(5)
%% Es4
n=10;
vet2=2*ones(n,1);
D2=diag(vet2);
vet1=-ones(n-1,1);
D1=diag(vet1,1);
D11=diag(vet1,-1);
A=zeros(n);
A=A+D2+D1+D11
DetA=det(A)
N1= norm(A,1)
N2= norm(A,2)
NI= norm(A,inf)
K1=cond(A,1)
K2=cond(A,2)
KI=cond(A,inf)
eig(A)
[V,L]=eig(A) 
% L matrice degli autovalori sulla diagonale
L(3,3)
% V matrice degli autovettori: per ciascuna colonna ho l'autovettore
% dell'autovalore corrispondente
V(:,3)
rhoA=max(abs(eig(A)))
norm(A,2)
inv(V)*A*V
diag(eig(A))
% sono uguali
%% Es5
clear all, close all
% in matlab l'* è prodotto matriciale
% .* prodotto costruendo vettore che fa prima comp * prima comp.....
f=@(x) x.*sin(x)+(1/2).^sqrt(x); % pointwise
g=@(t) t.^4+log(t.^3+1);
y= [0 1 2 exp(1) 3 pi]
fy=f(y)
gy=g(y)
% ro- unisce i puntini
plot(y,fy,'ro-','LineWidth',2)
%% Es6
pippo=numeroprimo(7)
% function handle @ comodo, quando una funzione veloce
% altrimenti facciamo un'altra funzione su un altro file
help numeroprimo % ti fa vedere la descrizione che avevi messo nella % del file .m
%% Es9
% definisco la funzione f(x)
f=@(x) 2+(x-3).*sin(5*(x-3))
xvect=linspace(0,6,300); % vettore di valutazione
yf=f(xvect); % valutazione della funzione
plot(xvect,yf,'LineWidth',2) % rappresento la funzione
% aggiungo le rette
r1=@(x) 2+(x-3)
r2=@(x) 2-(x-3)
hold on % sovrappongo al precedente grafico 
plot(xvect,r1(xvect),xvect,r2(xvect),'LineWidth',2) % rappresento le due rette
%% Es10
clear all, close all,clc
x=[-2 -1 0 1 2 3]
x>=0 % funge da selezionatore: restituisce 1 se è maggiore di 0, 0 altrimenti
f=@(x) (-x.^2+2*x).*exp(-x).*(x>=0)-sqrt(x.^2-x).*(x<0)
% tutti quelli non definiti per x<0 si annullano idem dall'altra parte.
x=linspace(-10,10) % 100 valori tra -10 e 10 (default) uguale a -10:100:10
plot(x,f(x))