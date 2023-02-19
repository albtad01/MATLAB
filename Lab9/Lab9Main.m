%% (LAB8) COME SI FA IN GENERALE ORDINE CONVERGENZA ANALITICAMENTE?
% Dobbiamo trovare rette pendenze varie, ma è dispendioso
% ESEMPIO: TRAPEZIO
% Trapezio: |I(f)-pol(f)|<=...max(f''(x))*H^p
% p? H-> Eh<=c*H^p
% H/2 -> Eh<=c*(H/2)^p
% Eh/E(h/2)= c*H^p/(c*h/2^p) -> 2^p -> p=log2(Eh/E(h/2)) 
% i due Eh si trovano con matlab.
% 2 per trapezi, 4 per cavalieri simpson
%% Esercizio 1

% a)
% grado es.2= impostare sist lineare che calcoli i pesi, affiché venga
% esatto anche con questa formula di quadratura
% VEDI FOGLIO
% Possiamo inventare a nostra scelta nuovi nodi e quindi nuove formule di
% quadratura
x0=-sqrt(3/5);
x1=0;
x2=sqrt(3/5);
A=[1 1 1; -sqrt(3/5) 0 sqrt(3/5); 3/5 0 3/5];
b=[2;0;2/3];
w=A\b
[xx,ww]=lgwt(3,-1,1)

% b)
% Trasliamo i pesi nel nuovo intervallo di integrazione in cui vogliamo
% integrare x: [-1,1] -> t: [0,1].
T=@(t) 0.5*(1+t);
xtilde(1)=T(x0)
xtilde(2)=T(x1)
xtilde(3)=T(x2)
wtilde=w/2;

% c)
f= @(x) 1./(x+2);
g= @(x) sqrt(x);
I_ex_f= log(3/2);
I_ex_g= 2/3;
wtilde
f_xtilde=f(xtilde)
% I2_f= ww(1)*f(xtilde(1))+ww(2)*f(xtilde(2))+ww(3)*f(xtilde(3))
% I2_g= ww(1)*g(xtilde(1))+ww(2)*g(xtilde(2))+ww(3)*g(xtilde(3))
I2_f=f(xtilde)*wtilde
I2_g=g(xtilde)*wtilde

abs(I_ex_f-I2_f)
abs(I_ex_g-I2_g)

% d)
f= @(x) 1./(x+2);
Err=[];
I_ex_f=log(3/2);
Nvect=[1:7]
for n=Nvect
    [x,w]=lgwt(n+1,0,1)
    I_flg=w'*f(x)
    Err=[Err abs(I_ex_f-I_flg)]
end
semilogy(Nvect,Err,'LineWidth',2)
% e)
f= @(x) 1./(x+2);
g= @(x) sqrt(x);
N=1:7;
a=0;
b=1;
err_f_legendre=zeros(7,1);
err_f_trapcomp=zeros(7,1);
err_g_legendre=zeros(7,1);
err_g_trapcomp=zeros(7,1);
for n=N
    [x,w]=lgwt(n+1,a,b);
    I_legendre_f= w'*f(x);
    I_trapcomp_f=trapcomp(a,b,n,f);
    I_legendre_g= w'*g(x);
    I_trapcomp_g=trapcomp(a,b,n,g);
    err_f_legendre(n)=abs(I_legendre_f-I_ex_f);
    err_f_trapcomp(n)=abs(I_trapcomp_g-I_ex_f);
    err_g_legendre(n)=abs(I_legendre_g-I_ex_g);
    err_g_trapcomp(n)=abs(I_trapcomp_g-I_ex_g);
end
semilogy(N,err_f_legendre,N,err_f_trapcomp,'LineWidth',2);
legend('f Legendre ','f Trap')
xlabel('Grado formula quadratura');
ylabel('Errore');
figure
semilogy(N,err_g_legendre,N,err_g_trapcomp,'LineWidth',2);
legend('g Legendre','g Trap')
xlabel('Grado formula quadratura');
ylabel('Errore');
% retta in scala logaritmica = esponenziale: stiamo apposto
%% f)
ff=@(x) 2./(x+2).^3; % è la derivata seconda, non prima!
x=linspace(0,1,500);
normaf=norm(ff(x),inf)
Nmin=ceil(sqrt(normaf/(12e-6)))
%% Esercizio 2
% Svolto carta e penna sul quaderno (e tablet)