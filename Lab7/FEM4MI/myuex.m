function y=myuex(x)
    n=4;
    xi=[-1 -0.5 0 0.5 1];
    ui=[0 1.01 2.03 0.99 0];
    P=polyfit(xi,ui,n);
    y=polyval(P,x);
end