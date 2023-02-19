% Funzione tramite FILE
function[ValoreDeterminante]= Determinante2x2(A)
% calcola il determinante di una matrice 2x2
[nrighe,ncolonne]=size(A);
if(nrighe==ncolonne & nrighe==2)
    ValoreDeterminante=A(1,1)*A(2,2)-A(2,1)*A(1,2);
else
    disp('La matrice non è 2x2');
end