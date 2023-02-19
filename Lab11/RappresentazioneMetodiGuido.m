%% Esercizio 1

clc
clear
close

% eulero esplicito

ReZ = linspace(-5,5,1000);

ImZ = linspace(-5,5,1000);

%con un numero dispari di punti riesco a metterci dentro anche l'origine

[a,b] = meshgrid(ReZ,ImZ);

gZ = @(re,im) abs(1+re+i*im);

%funzione G va da c a c (r2 ad r2), quindi sta in spazio di dimensione 4,
%non la posso visualizzare

contour(a,b,gZ(a,b),[1 1],'r:','LineWidth',2)
hold


% eulero implicito

gZ = @(re,im) abs(1./(1-(a+i*b)));
contour(a,b,gZ(a,b),[1 1],'g:','LineWidth',2)

% crank nicolson

gZ = @(re,im) abs((1+(a+i*b)/2)./(1-(a+i*b)/2));
contour(a,b,gZ(a,b),[1 1],'b:','LineWidth',2)

% heun

gZ = @(re,im) abs(1+a+i*b + ((a+i*b).^2)/2);
contour(a,b,gZ(a,b),[1 1],'m:','LineWidth',2)

hold
grid
legend('EE','EI','CN','Heun')

