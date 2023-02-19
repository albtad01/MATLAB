clc
clear all
close all

%% Esercizio 1
% a)
n=50;
A=diag(4*ones(50,1))
DS=diag(-1*ones(49,1),1);
DSS=diag(-1*ones(48,1),2);
DD=diag(-1*ones(49,1),-1);
DDD=diag(-1*ones(48,1),-2);
A=A+DS+DSS+DD+DDD
b=0.2*ones(50,1)
toll=1e-5
x0=zeros(50,1);
spy(A) % rappresentazione degli elementi diversi da 0 dentro A
% b)
% A SDP
if(min(eig(A))>0 & isequal(A,A'))
    disp('A sdp');
end
% Condizionamento
condAnalitico=max(eig(A))/min(eig(A)) % dato che è SDP
condComputer=cond(A)
% c)
P=eye(n)
tol=1e-5;
nmax=1e5;
%alpha_opt=2/(min(eig(A))+max(eig(A)));
%alpha=[0.2 0.33 alphaopt]
%for ii=1:3
%    [x,k(ii)]=richardson(A,b,P,x0,tol,nmax,alpha(ii))
%end
[x,k]=richardson(A,b,P,x0,tol,nmax,0.2)
%% d)
alpha_opt=2/(min(eig(A))+max(eig(A)))
rhovect=[];
kvect=[];
for alpha=[0.2 0.33 alpha_opt] % alpha=[0:0.1:0.5]
    [x,k]=richardson(A,b,P,x0,tol,nmax,alpha);
    kvect=[kvect k];
    rho=max(abs(eig(eye(n)-alpha*(P\A))));
    rhovect=[rhovect rho];
end
kvect
rhovect
% e) 
% Verifichiamo il rispetto della stima teorica
xex=A\b;
C=(cond(A)-1)/(cond(A)+1)
norm(xex-x)
C^k*norm(xex-x0)
norm(xex-x)<=C^k*norm(xex-x0)

%% Esercizio 2
% vedi fem
