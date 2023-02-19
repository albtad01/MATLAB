clear all
close all
clc
n=[1 2]
length(n)
%% Esercizio 1
% POLYFIT polyfit(xi,yi,n)
% Restituisce i coefficienti del polinomio interpolante passante per tutti i punti
% xi ed yi: se ho n+1 punto il polinomio sarà di grado n.
% POLYVAL polyval(P,xx)
% Valuta il polinomio P nei punti xx dati in pasto.
% INTERP1 interp1(xx,yy,X)
% Ne calcola il polinomio interpolante composito di grado 1
% nei nodi (xx,yy) e lo valuta in un vettore di punti assegnati X.

% FUNZIONE DI RUNGE: funzione e intervallo
f=@(x) 1./(1+x.^2);
a=-5; 
b=5;
xx=linspace(a,b,500) % per disegnare la funzione "mima" l'intervallo reale [a,b]
plot(xx,f(xx),'LineWidth',2,'color','black') % per visualizzare f(x)

% a)
% creiamo l'interpolante Pi_n(f)
n=10;
% 1. campionamento di f
h=(b-a)/(n+1);
% NODI NON EQUISPAZIATI CGL (punto c) 26-29
% costruire M nodi (xi,yi)
i=0:n;
xhat=-cos(pi*i/n); % CGL
xi=(a+b)/2+((b-a)/2).*xhat; % Attualizzazione nell'intervallo
% anche qui i nodi non equispaziati sono n+1, come equispaziati
% NODI EQUISPAZIATI per approssimare la funzione: utilizzo il linspace:
% xi=linspace(a,b,n+1) % quanti e come sono?
 yi=f(xi) % come sono?
% 2. visualizzare i nodi
hold on
plot(xi,yi,'o') % per visualizzare i nodi 'o'
% sono soltanto i nodi che vengono valutati sulla funzione vera

% 3. interpolazione vera e propria (finora utilizzavo la funzione vera)
% calcolo i coeff. P del polinomio interpolante Pi_n(f) ho n+1 punti ->
% polinomio di grado n, quindi metto n su polyfit
P=polyfit(xi,yi,n); % ne devi mettere n -> 10 cosa ci va dentro? usare HELP
% valutiamo il polinomio sui "Reali" ->
% cioè su un vettore opportuno di punti
yy=polyval(P,xx); % usare HELP
% 4. visualizzo il polinomio 
% hold on sempre attivo
hold on
plot(xx,yy,'LineWidth',2,'color','red') % disegno il polinomio interpolante
legend('f','nodi','Pi_n(f)')
% 5. errore
Err=norm(f(xx)-yy,inf)
% f(xx) = valore della funzione vera
% yy= valore delle xx valutate nel polinomio interpolatore
% omogeneo perché io ho tante xx quante yy
%% b)
% Analizziamo il polinomio nodale
W=poly(xi); % restituisce un polinomio di grado n+1 che ha come radici quelle di xi
% è come la formula di W=w(n+1), solo che anziché fare la
% produttoria cerco un polinomio che ha come radici xi (equivalente).
Wy=polyval(W,xx); % valuta xx nel polinomio W al fine di graficarlo 
figure % grazie a questo figure io costruisco un'altra finestra per un altro grafico: prima ne avevo una con tutti i grafici con hold on, ora ne creo un'altra.
plot(xx,Wy,'LineWidth',2);
hold on
plot(xi,zeros(size(xi)),'o'); % mostra dove stanno gli zeri nei nodi
grid on

%% c)
% Utilizziamo i nodi NON equispaziati: Chebyshev-Gauss-Lobatto (CGL): 
% Righe 26-29

%% MS Forms
% l'errore nei punti di interpolazione è 0 è come se avessi f(xi)-yi
% nell'errore; è negli altri punti che potrei avere un errore

%% Esercizio 2: Homework
clc;
clear all;
close all;

% Suggerimenti:
% interp1(X,Y,xx)
% calcola in xx l'interpolazione lineare dei punti (X(i),Y(i))
% pcg(n)

% f(x) su [a,b]:
f=@(x) exp(-x.^2).*sin(x);
a=-2;
b=3;
xx=linspace(a,b,1000);
yy=f(xx);
plot(xx,f(xx),'k');
% a)
n=3; % 3 sottointervalli -> 4 nodi
H=(b-a)/n; % ampiezza sottointervalli 
x_nod=linspace(a,b,n+1);
y_nod=f(x_nod);
P_dis=interp1(x_nod,y_nod,xx) % calcola in xx l'interpolazione COMPOSITA lineare dei punti x_nod y_nod
hold on
plot(x_nod,y_nod,'bo')

plot(xx,P_dis,'LineWidth',2)
legend('f','nodi','interp1');
% b)
Eh=norm(yy-P_dis,inf)
%% c)
a=-2;
b=3;
f=@(x) exp(-x.^2).*sin(x);
xx=linspace(a,b,500);
yy=f(xx);
% Errore nell interpolazione al variare di nodi:
% H rappresenta l'ampiezza dei nodi equispaziati, che all'aumentare dei
% nodi diminuisce (al crescere dei nodi diminuisce l'ampiezza dei sottointervalli, quindi aumenta l'accuratezza)
HH=[];
err_max=[];
for n=2.^(2:7)
    H=(b-a)/n;
    HH=[HH H];
    x_nod=linspace(a,b,n+1); % grado n -> n+1 punti
    y_nod=f(x_nod);
    P_dis=interp1(x_nod,y_nod,xx); % valuta direttamente i punti xx
    err_max=[err_max (norm(yy-P_dis,inf))];
end
HH % all'aumentare di n, H diminuisce: HH decrescente
HH2=HH.^2; % idem HH^2
err_max;
emax=max(err_max);
% figure
% plot(HH,err_max,'ro-',HH,HH,'k--',HH,HH.^2,'k');
% legend('errore','H','H^2');
% più piccolo è H, più piccolo sarà l'errore (aumento N)
figure
loglog(HH,err_max,'ro-',HH,HH,'k--',HH,HH.^2,'k')
legend('errore','H','H^2','H^10')
% polinomio interpolatore composito di grado 1: deve stare sotto H^(1+1) ed infatti sta sotto H^2!

% SODDISFA LA STIMA TEORICA:
% vedi Lab6 Interpolazione Composita
