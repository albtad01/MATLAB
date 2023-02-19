clc 
clear all
close all
format short e
n=22;
f=@(x) sin(2*pi*x);
a=-1;
b=1;
xi=linspace(a,b,n+1);
yi=f(xi);
P=polyfit(xi,yi,n);
P(1)
P