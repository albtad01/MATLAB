%% ESERCIZIO 1
% Calcoliamo il grado di esattezza di GL sperimentalmente.
% Assicurarsi che pesi e nodi generati nell'intervallo di interesse.
clear all
clc
n = 3;
[xn,wn] = lgwt(n+1,0,1);
xn = 2*xn-1; % trasformazione intervallo [0,1] -> [-1,1]
wn=2*wn;
for p = 0:10 % per verificare il grado di esattezza faccio variare l'esponente
    fun = @(x) x.^p;
    I_gl = wn'*fun(xn)
    I_ex = (1/(p+1))*(1-(-1)^(p+1))
    err = abs(I_gl - I_ex); % approssimazione formula gaussiana - risultato esatto
    if err > 1e-15
            grado_esattezza = p-1 % infatti 2*3+1=7! 2n+1 verificata
            % faccio p-1 perché quest'errore non va bene: devo tornare all'esponente precedente
    break 
    end
end
%% ESERCIZIO 2