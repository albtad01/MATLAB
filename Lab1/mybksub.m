function [x]=mybksub(U,y)
    % Check... (triangolare superiore + dimensioni omogenee
    n=size(U,1);
    x=zeros(n,1);
    x(n)=y(n)/U(n,n);
    for ii=(n-1):-1:1
        x(ii)=(y(ii)-(U(ii,n:-1:(ii+1)))*x(n:-1:(ii+1)))/U(ii,ii);
    end
end