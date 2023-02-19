syms x y;
syms f h;
f=int(-4*pi^2*sin(2*pi*x))
h=int(f)

y=sin(2*pi*x)
dy=diff(y)
[errors_table,rates]=C_convergence_test('Test1')
% l'errore ha pendenza H.
% andamento della retta (1)