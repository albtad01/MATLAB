function plotzeros(fun, x_limits, y_limits, varargin)

% plotzeros(fun, [X_MIN X_MAX], [Y_MIN Y_MAX], sample_len)
%
% Risoluzione grafica di un sistema non lineare di due equazioni in due
% incognite, nella forma f(x) = 0. In verde è tracciato il luogo degli zeri
% della prima componente di f, in blu quello della seconda.
%
% Parametri di ingresso:
%
% fun           function handle contenente la funzione associata al 
%               sistema non lineare 2x2.
% [X_MIN X_MAX] vettore contenente gli estremi dell'asse delle ascisse.
% [Y_MIN Y_MAX] vettore contenente gli estremi dell'asse delle ordinate.
%
% sample_len    (OPTIONAL) numero di valori campionati su ciascun asse per
%               realizzare il plot. Default: 200

if nargin > 3
    sample_len = varargin{1};
else
    sample_len = 500;
end

v_dis_x = linspace(x_limits(1), x_limits(2), sample_len);
v_dis_y = linspace(y_limits(1), y_limits(2), sample_len);
n_dis_x = length(v_dis_x);
n_dis_y = length(v_dis_y);

Z_1 = zeros(n_dis_y, n_dis_x);
Z_2 = zeros(n_dis_y, n_dis_x);

for i = 1:n_dis_x
    for j = 1:n_dis_y
        
        funz = fun([v_dis_x(i); v_dis_y(j)]); 
        
        Z_1(j,i) = funz(1);
        Z_2(j,i) = funz(2);
        
    end
end

contour(v_dis_x, v_dis_y, Z_1, [0 0], 'Linecolor',[0 1 0], 'Linewidth', 2)
hold on
contour(v_dis_x, v_dis_y, Z_2, [0 0], 'Linecolor',[0 0 1], 'Linewidth', 2)
axis equal
set(gca, 'FontSize', 14)
grid on

end