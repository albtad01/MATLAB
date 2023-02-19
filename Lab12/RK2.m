function [t_h,u_h]=RK2(f,t0,t_max,y_0,h)
    % Implementa il metodo di Runge Kutta a due stadi esplicito
    % per la risoluzione di un generico problema di Cauchy.
    % ESPLICITO, quindi non devo calcolare l'inversa
    t_h=t0:h:t_max;
    t_h=t_h';
    N=length(t_h);
    u_h=zeros(N,1); % devo sempre farlo di grandezza Nx1, altrimenti lo prende tipo matrice
    u_hstar=zeros(N,1);
    u_h(1)=y_0;
    for n=2:N
        u_hstar(n)=u_h(n-1)+h*f(t_h(n-1),u_h(n-1));
        u_h(n)=u_h(n-1)+h/2*(f(t_h(n-1),u_h(n-1))+f(t_h(n),u_hstar(n)));
    end
    % è tipo heun (H)
end