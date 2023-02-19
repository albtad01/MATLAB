clear all
close all
clc
%% ESERCIZIO 1
% a) 
f=@(x) x.^3;
Imedcomp=pmedcomp(-1,2,5,f)
% b)
f=@(x) x.^3;
Itrapcomp=trapcomp(-1,2,5,f) 
% c) 
f=@(x) x.^3;
Isimpcomp=simpcomp(-4,9,5,f)
% d)
%f=@(x) cos(pi/2*x);
f=@(x) x.^(1/2);
a=0; b=1;
%Iex=2/pi;
Iex=2/3;
NVect=2.^[1:7]; % il numero di sottointervalli varia come N=2,4,8,...,128
errpmed=[];
errsimp=[];
errtrap=[];
for N=NVect; 
    Ipmed=pmedcomp(a,b,N,f);
    Isimp=simpcomp(a,b,N,f);
    Itrap=trapcomp(a,b,N,f);
    errpmed=[errpmed abs(Ipmed-Iex)];
    errsimp=[errsimp abs(Isimp-Iex)];
    errtrap=[errtrap abs(Itrap-Iex)];
end
errpmed
errsimp
errtrap
H=(b-a)./NVect;
figure
loglog(H,errpmed,H,errsimp,H,errtrap,'LineWidth',2)
hold on 
loglog(H,H,H,H.^2,H,H.^3,H,H.^4,'LineWidth',2,'LineStyle','--')
legend('Err pt med','Err simp','Err trap','H','H^2','H^3','H^4')
% Soddisfano la stima teorica perché pendenza uguale agli errori compositi
% e)
% Non soddisfa perché la funzione nell'intervallo non è C2 né C4
% Non ha quindi regolarità sufficienti: la stima dell'errore salta
%% ESERCIZIO 2
% a)
% lgwt calcola i pesi e i nodi della formula di quadratura GL (Download su WeBeep)
n=3; % grado n -> n+1 nodi
[xn,wn]=lgwt(n+1,-1,1); % vettori colonna che calcolano n+1 nodi e pesi di GL nell'intervallo [-1,1]
for p = 0:9
    fun = @(x) x.^p;
    % indici p+1 perché parto da 1 e non da 0 su MatLab
    I_gl(p+1)=wn'*fun(xn);
    I_ex(p+1) = (1/(p+1))*(1- (-1)^(p+1)); % formula di risoluzione integrale esatto
    err(p+1) = abs(I_gl(p+1) - I_ex(p+1));
end
err
% primo errore: p=8 (nel vettore sta in posizione 9) -> grado di esatteazza 7 = 2*n+1