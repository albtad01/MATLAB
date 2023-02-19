clc 
clear all
close all

%% ESERCIZIO 1
% a)
t_0=0;
t_max=15;
lambda=1;
y_0=1;
f=@(t,y) -lambda*y;
y_ex=@(t) exp(-lambda*t);
tt_ex=linspace(t_0,t_max,1000); % campionamento più fine
plot(tt_ex,y_ex(tt_ex),'LineWidth',2);
% b) c)
h=0.5;
[th_RK2,uh_RK2]=RK2(f,t_0,t_max,y_0,h);
hold on;
plot(th_RK2,uh_RK2,'LineWidth',2);
legend('f','Approx. RK2');
% d)
figure;
h=0.5; % 1.5 2.1
[th_EA,uh_EA]=eulero_avanti(f,t_0,t_max,y_0,h);
[th_RK2,uh_RK2]=RK2(f,t_0,t_max,y_0,h);
plot(tt_ex,y_ex(tt_ex),th_EA,uh_EA,th_RK2,uh_RK2,'LineWidth',2);
legend('f','Approx. EA','Approx. RK2');
%%
figure;
plot(tt_ex,y_ex(tt_ex),'LineWidth',2);
hold on;
for h=[0.5 1.5 2.1]
    [th_RK2,uh_RK2]=RK2(f,t_0,t_max,y_0,h); % metti eulero avanti dopo
    [th_EA,uh_EA]=eulero_avanti(f,t_0,t_max,y_0,h);
    plot(th_EA,uh_EA,th_RK2,uh_RK2,'LineWidth',2);
end
legend('Esatta','EA (h=0.5)','RK2 (h=0.5)','EA (h=1.5)','RK2 (h=1.5)','EA (h=2.1)','RK2 (h=2.1)')
% h 0.5 1.5 siamo safe: metodo convergente e ass. stabile
% h 2.1 esco dalla regione di ass. stabilità di RK e un-> no a 0 (cresce)
% Dato un metodo numerico, dato il PM commentiamo convergenza e ass. stab.
% a seconda dei valori di h e lambda.
% In un problema generico possiamo valutare consistenza, convergenza
% ass. stab. solo nel PM

%% ESERCIZIO 2
clc 
clear all
close all
% EI è un metodo implicito: devo linearizzare
% a) b)
f=@(t,y) y .* 1/ (1+t.^2);
a= @(t) 1./(1+t.^2); % quello che moltiplica la y
b=@(t) 0*t; % è quello che non moltiplica la y
y_0=1;
t_0=0;
t_max=20;
Eh=zeros(4,1);
y_ex=@(t) exp(atan(t));
tt_ex=linspace(t_0,t_max,1000);
plot(tt_ex,y_ex(tt_ex),'LineWidth',2);
hold on;
ii=1;
for Nh=[10,50,100,500]
    h(ii)=20/Nh;
    [th_EI,uh_EI]=eulero_indietroab(a,b,t_0,t_max,y_0,h(ii));
    plot(th_EI,uh_EI,'LineWidth',2);
    Eh(ii)=max(abs(y_ex(th_EI)'-uh_EI));
    ii=ii+1;
end
legend('f','EI H10','EI H50','EI H100','EI H500');
figure;
Eh
Nh=[10,50,100,500];
loglog(h,Eh,h,h,h,h.^2,'LineWidth',2);
legend('Errore EI','H1','H2');
% Qualunque metodo numerico non è detto che converga sempre perfetto,
% a volte intervalli di SUPER/SOTTO - CONVERGENZA
% a volte quindi convergenza non sempre parallela e rispettata al 100%
% qui teoricamente doveva venire parallelo ad H1 (converg. di ordine 1)
%% c)
help ode23
% ode23 risolve equazioni NON STIFF (no oscillazioni o robe strane)
tspan=[0 20]; % ESTREMI intervallo
y_0=1;
f=@(t,y) y ./ (1+t.^2);
[th_ODE23,uh_ODE23]=ode23(f,tspan,y_0) 
% f gli diamo la funzione f(t,y) del problema di cauchy
% tspan tempo iniziale e tempo finale
% y_0 condizione iniziale
plot(tt_ex,y_ex(tt_ex),th_ODE23,uh_ODE23,'LineWidth',2);
legend('f','RK23');
th_ODE23
% quasi uguale il grafico
% distanza tra 0 0.08 ecc diversi: capaci in base a una previsione di usare timestep molto fine dove serve e molto lasco dove serve
