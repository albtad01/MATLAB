function [y]=myforce(x)
    % Approssimo la forzante f_i con il polinomio interpolante P nei 
    % nodi (x_i,f_i)
    x_i=[-1 -0.5 0 0.5 1];
    f_i=[-0.9 0.01 1.01 0 -1.05];
    P  = polyfit(x_i,f_i,4) % 5 punti -> polinomio di grado 4
    y  = polyval(P,x); % valuto il polinomio nei punti x
end