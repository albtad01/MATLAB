clc
clear all
close all
%% Esercizio 1
% a) e b)
% y per essere trovata deve essere lispschitziana uniformemente rispetto t
% applico eulero in avanti (EE). Diamo per scontato che lo sia.
f=@(t,y) -2*t.*y;
y_ex=@(t) -2*exp(-t.^2); % soluzione carta e penna
t_0=0;
t_max=3;
y0=-2;
h1=3/6;
h2=3/20;
[th_EA,uh_EA]=eulero_avanti(f,t_0,t_max,y0,h1)
length(th_EA)
tt=linspace(t_0,t_max,1000);
figure;
plot(tt,y_ex(tt),th_EA,uh_EA,'LineWidth',4);
legend('esatta','EA')
% c)
% Applico eulero all'indietro (EI). Dato che non so applicarlo ancora come metodo di
% punto fisso, devo cercare di 

err=[];
a = @(t) -2*t; % a è una funzione in t, nel problema a=-2*t
b = @(t) 0*t; % b è una funzione in t, nel problema b=0 per ogni t
% Distinguo la parte a che moltiplica la y e la parte b che non moltiplica niente.
% f(t,y)=a(t)*y+b(t)
% in questo caso posso ben isolare la y e calcolare u(n+1)

h = [1/4, 1/8, 1/16, 1/32, 1/64] % passi di h
err_EA=[];
err_EI=[];
for ii = 1:length(h)
    [th_EA,uh_EA]=eulero_avantiab(a,b,t_0,t_max,y0,h(ii)); % anche se potevo direttamente chiamare eulero_avanti
    [th_EI,uh_EI]=eulero_indietroab(a,b,t_0,t_max,y0,h(ii));
    eh_EA=norm(y_ex(th_EA)'-uh_EA,inf);
    eh_EI=norm(y_ex(th_EI)'-uh_EI,inf); % valuto la y per gli istanti temporali e guardo quanto viene la soluzione approssimata rispetto ad essa.
    err_EA=[err_EA eh_EA];
    err_EI=[err_EI eh_EI];
end
figure
plot(tt,y_ex(tt),th_EI,uh_EI,'LineWidth',2);
legend('f','EI Approx.')
figure
loglog(h,err_EA,h,err_EI,h,h,'LineWidth',2)
legend('Errore Eulero Avanti','Errore Eulero Indietro','ordine 1')

%% ESERCIZIO 2
% a) b)
y_ex=@(t) 2*t.^(1/3)-log(t)-4;
treal=linspace(1,10,1000);
h=1/5;
t_0=1;
t_max=10;
f=@(t,y) y/(3*t)+(log(t)+1)/(3*t);
y0=-2;
[th_H,uh_H]=heun(f,t_0,t_max,y0,h);
th_H
uh_H
figure
plot(treal,y_ex(treal),th_H,uh_H,'LineWidth',2);
legend('f','Approx. Heun')
% c) d)
[th_CN,uh_CN]=CN(f,t_0,t_max,y0,h);
figure
plot(treal,y_ex(treal),th_CN,uh_CN,'LineWidth',2);
legend('f','Approx. CN')
ii=1;
errH=[];
errCN=[];
for h=[1/5 1/10 1/20 1/40]
    [th_H,uh_H]=heun(f,t_0,t_max,y0,h);
    [th_CN,uh_CN]=CN(f,t_0,t_max,y0,h);
    errH=[errH norm(y_ex(th_H)'-uh_H,inf)];
    errCN=[errCN norm(y_ex(th_CN)-uh_CN,inf)];
end
errH
errCN
figure
h=[1/5 1/10 1/20 1/40];
loglog(h,errH,h,errCN,'LineWidth',2);
hold on
loglog(h,h,h,h.^2,h,h.^3,'LineWidth',2);
legend('Errore Heun','Errore CN','H','H2','H3');

