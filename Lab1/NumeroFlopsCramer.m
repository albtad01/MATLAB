function [NumFlops]=NumeroFlopsCramer(A)
% Restituisce il costo computazionale del metodo di cramer applicato alla matrice A
% function [OUTPUT]=NomeFunzione(INPUT)
% help not: ~ [~= significa DIVERSO]
if(size(A,1)~=size(A,2))
    error('Non posso applicare Cramer a questa matrice')
else
    NumFlops=factorial(size(A,1)+1); % (n+1)!
end
