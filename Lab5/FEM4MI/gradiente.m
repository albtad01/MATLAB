function [xk, k] = gradiente(A, b, P, x0, tol, nmax)

n = length(b);
if ((size(A,1) ~= n) || (size(A,2) ~= n) || (length(x0) ~= n))
  error('Dimensioni incompatibili')
end

% E' possibile utilizzare una sola variabile x al posto di xn e xv viste
% nel laboratorio precedente.

x = x0;
k = 0;
r    = b - A * x;
res_normalizzato  = norm(r) / norm(b);
xk=[x0];
while ((res_normalizzato > tol) && (k < nmax))
     z = P \ r;
     % alpha= (r'*r)/(r'*A*r); %% NON Precondizionato
     alpha= (z'*r)/(z'*A*z); %% Precondizionato
     x = x + alpha * z;
     xk=[xk x];
     r = b - A * x; % equivalente a: r = r - alpha * A * z;
     res_normalizzato  = norm(r) / norm(b);
     k = k + 1;
end

if (res_normalizzato < tol)
     fprintf('Richardson converge in %d iterazioni \n', k);
else
     fprintf('Richardson non converge in %d iterazioni. \n', k)
end
