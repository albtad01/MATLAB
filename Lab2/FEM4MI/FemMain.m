% b)
[errors,solutions,femregion,Dati,K2A]=C_main1D('Test1',4)
% c)
K2=ones(4,1);
h=ones(4,1);
for ii=1:4
    nRef=ii+1;
    h(ii)=pi./(2.^nRef);
    [errors,solutions,femregion,Dati,K2A(ii)]=C_main1D('Test1',nRef);
end
figure
% bilogaritmica = loglog
% semilogaritmica= semilogy
loglog(h,K2A,'LineWidth',2);
hold on
loglog(h,h.^(-1),'LineWidth',2);
loglog(h,h.^(-2),'LineWidth',2);
loglog(h,h.^(-3),'LineWidth',2);
legend('K2A','h^(-1)','h^(-2)','h^(-3)');
% Dato che il grafico di K2A è parallelo alla retta h^(-2), allora
% alpha=2