clc
clear all
close all

%% ESERCIZIO 1
% Matrice di Vandermonde:
% M=[x(i)^n x(i)^n-1 ... x(i) 1] i=0,...,m [Matrice (m+1)x(n+1)]
% c=[c(i)] i=n,n-1,...,0 (nx1)
% y=[y(i)] i=0,...,m (mx1)
% Mc=y (m+1)x(n+1) * (n+1)x1 = (m+1)x1
% nella trattazione useremo m+1 al posto di m perché ordine m ->
% nell'elevare a potenza ciascuna componente x, considero anche 0,...,m
% quindi ho m+1 elevamenti a potenza

% a)
m=31;
x_nod=linspace(0,2,m+1); % linspace (inizio,fine,numPunti)
f= @(x) 2*x.^2+0.25*sin(20*pi*x);
plot(x_nod,f(x_nod),'*','LineWidth',2); % Aggiungendo '*' dico di stampare nuvola di punti senza collegamento

% b)
% vander restituisce la matrice di Vandermonde quadrata nxn, dove
% le colonne del vettore sono x(i)^(n-j) j=0,...,n (definita come riga 6)
V=vander(x_nod)
% La matrice avrà dimensione (m+1)x(m+1)
V
size(V)
% Esempio con 4 elementi
% Dobbiamo costruire la matrice di Vandermonde nel caso n=3
n=3
% così restituisce una 32x32, ma noi vogliamo solo fino grado 3 (quindi ultime 4 colonne)
% PASSAGGIO AI MINIMI QUADRATI: voglio passare da (m+1)x(m+1) -> ad (m+1)x(n+1) (così avrò grado massimo 3)
M=V(:,m+1-n:m+1) % si prendono soltanto le ULTIME 4 colonne (così arrivo fino all'esponente 3)
size(M) % infatti è una 32x4
y_nod=f(x_nod)';

% M è di vandermonde -> M'*M s.d.p.
% c_3,c_2,c_1,c_0 ordinate dal grado massimo al grado minimo c=4x1
% RISOLUZIONE MINIMI QUADRATI: Mc=y -> (M'*M)\(M'*y)
c_backslash=M\y_nod
c_normali= (M'*M)\(M'*y_nod)

err_normali=norm(c_backslash-c_normali,inf)

cond(M)
cond(M'*M)
% mal condizionato se faccio M'*M: non conviene, soprattutto se n=10
% Il condizionamento di M'*M è troppo alto. Cambiamo strategia.

% c)
r=rank(M) % fondamentale che il rango sia massimo: r=n+1=4

% FATTORIZZAZIONE QR (computazionalmente migliore)
% DECOMPOSIZIONE QR "CLASSICA" ([Q,R]=qr(M))
% -> Q (m+1)x(m+1) ortogonale (tutti i vettori sono ortogonali tra loro, vedi
% prodotto scalare tra righe e colonne deve venire zero) e Q^-1=Q'
% -> R (m+1)x(n+1) trapezoidale superiore, tutti zeri dalla riga n+2 in giu
% DECOMPOSIZIONE QR RIDOTTA ([QTilde,RTilde]=qr(M,0)
% -> Qtilde (m+1)x(n+1) ortogonale
% -> Rtilde (n+1)x(n+1) quadrata triangolare superiore

%inv(M) % non si può trovare se non è quadrata
Minv=pinv(M) % inversa per le matrici rettangolari
norm(M)*norm(pinv(M))
cond(M)
[Q,R]=qr(M)
c_qr=R\(Q'*y_nod);
[QTilde,RTilde]=qr(M,0)
c_qrtilde=RTilde\(QTilde'*y_nod)
norm(c_qr-c_normali) % coefficienti sono comparabili a meno di un errore trascurabile (a meno che n=10)
% scopo: risolvere M*c=y
c_backslash=M\y_nod
err_qr=norm(c_qr-c_backslash,inf)
% Backslash > Fattorizzazione QR (Normale/Ridotta)

% d)
% confrontiamo graficamente metodo QR classico e metodo QR ridotto
x_dis=linspace(0,2,1000);
y_qr=polyval(c_qr,x_dis);
y_normali=polyval(c_qrtilde,x_dis)
% y_qrtilde=polyval(c_qrtilde,x_dis); % identici y_qr ed y_qrtilde: prenderò y_qr come riferimento

hold on
plot(x_dis,y_normali,x_dis,y_qr,'LineWidth',2);
legend('nuvola','qrtilde','qr')
err=norm(y_normali-y_qr,inf)
%% MS Forms
x_nod=linspace(0,2,m+1);
M=vander(x_nod)
eig(M)
min(eig(M))
abs(min(eig(M))) 
% A sdp
%% ESERCIZIO 2
% a)
xx=linspace(-1.5,1.5,1000);
yy=myforce(xx);
plot(xx,yy,'LineWidth',2)
% b) ... (FEM)

%% ESERCIZIO 3
clear all
clc
close all
f=@(x) sin(2*pi*x);
a=-1;
b=1;
xx=linspace(a,b,500);
yy=f(xx);
plot(xx,yy,'LineWidth',2);
hold on
% a)
n=20;
x_i=linspace(a,b,n+1);
plot(x_i,f(x_i),'LineWidth',2);
y_i=f(x_i);
P=polyfit(x_i,y_i,n);
P_y=polyval(P,xx);
Vq=interp1(x_i,y_i,xx)
plot(xx,P_y,'LineWidth',2);
legend('f','nodi','Pol');
% b)
e_max=norm(yy-P_y,inf)
% c)
delta=1e-2*rand(n+1,1);
y_i_tilde=(y_i)'+delta
P_tilde=polyfit(x_i,y_i_tilde,n);
P_y_tilde=polyval(P_tilde,xx);
plot(xx,P_y_tilde,'LineWidth',2);
legend('f','nodi','Pol','Pol_t');
% d)
e_max_tilde=norm(yy-P_y_tilde,inf)
% e)

figure 
somma_PhiX=0; 
for i=1:n+1
    znod=zeros(n+1,1); % vale zero su tutti i nodi
    znod(i)=1; % vale 1 nel nodo i-esimo 
    Phi_i=polyfit(x_i,znod,n); % calcolo i coeff. del polinomio 
    PhiX=polyval(Phi_i,xx); % lo valuto in X
    somma_PhiX=somma_PhiX+abs(PhiX); % somme parziali %
    % rappresento graficamente i polinomi:
    plot(x_i,znod,'*r',xx,PhiX,'LineWidth',2) 
    axis([-1 1 -5 5])
    pause(0.1)
end
%
% calcolo Lambda come il max delle somme 
Lambda_n=max(somma_PhiX)
% Calcolo anche le altre grandezze della stima teorica 
ErrP=norm(P_y-P_y_tilde,inf)
dy=norm(y_i-y_i_tilde,inf)
% verifico la stima
ErrP<=Lambda_n*dy
% MSForms
ErrMSForms=10^-2/Lambda_n

%% ESERCIZIO 4
clc
clear all
close all
n=8;
xi=[0.1800 0.3000 0.5000 0.6000 0.7200 0.7500 0.8000 0.9000 1.0000]';
yi=[0.0005 0.0010 0.0013 0.0015 0.0020 0.0045 0.0060 0.0070 0.0085]';
plot(xi,yi,'o');
hold on
xx=linspace(0.18,1,1000);
% Interpolazione polinomiale
P=polyfit(xi,yi,n);
y_pol=polyval(P,xx);
plot(xx,y_pol,'LineWidth',2);
% Interpolazione composita lineare
y_interp=interp1(xi,yi,xx);
plot(xx,y_interp,'LineWidth',2);
% Approssimazione nel senso dei minimi quadrati
V=vander(xi);
m=8
% Grado 1
nn=1;
M1=V(:,m+1-nn:m+1);
c_gr1=M1\yi;
% Grado 2
nn=2;
M2=V(:,m+1-nn:m+1);
c_gr2=M2\yi;
% Grado 4
nn=4;
M4=V(:,m+1-nn:m+1);
c_gr4=M4\yi
y_mq4=polyval(c_gr4,xx);
%plot(xx,y_mq4,'LineWidth',2);

% Metodo alternativo per grado 4: di fatti polyfit con grado 4 <-> sistema mq di grado 4
P4=polyfit(xi,yi,4);
y_mq4alt=polyval(P4,xx);
plot(xx,y_mq4alt,'LineWidth',2);
legend('nuvola','pol','interp comp','mq4');

% σ=0.400
y_pol_400=polyval(P,0.400) % Lagrange
y_interp_400=interp1(xi,yi,0.400) % Comp Lineare
y_mq4_400=polyval(c_gr4,0.400) % Minimi Quadrati
y_mq4alt_400=polyval(P4,0.4) % Minimi Quadrati alternativo (più semplice)

% σ=0.650
y_pol_650=polyval(P,0.650) % Lagrange
y_interp_650=interp1(xi,yi,0.650) % Comp Lineare
y_mq4_650=polyval(c_gr4,0.650) % Minimi Quadrati
y_mq4alt_650=polyval(P4,0.65) % Minimi Quadrati alternativo (più semplice)