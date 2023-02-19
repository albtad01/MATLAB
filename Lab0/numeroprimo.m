function [flag]=numeroprimo(n)
% la funzione restituisce 1 se il numero è primo, 0 altrimenti
flag=1; % il numero è primo

for p=2:sqrt(n)
    if mod(n,p)==0 % se è divisibile per qualche numero...
        flag=0; % il numero NON è primo
        break % ti butta fuori dalla function
    end
end

if flag==1
    disp('il numero è primo')
else
    disp('il numero NON è primo')
end