
function [xvect, it] = punto_fisso_prof( phi, x0, tol, kmax )
   %   [XVECT] = PUNTO_FISSO (PHI,X0,TOL,KMAX)
   %   trova un punto fisso della funzione PHI
   %   usando il metodo delle iterazioni di punto fisso
   %   e restituisce un vettore XVECT contenente le iterate del metodo.
   %   PHI  : funzione scalare che accetta una variabile scalare in input
   %   X0   : approssimazione iniziale
   %   TOL  : tolleranza per il criterio d'arresto (basato sull'incremento)
   %   KMAX : numero massimo di iterazioni concesso
   %
   %   [XVECT,NITER] = PUNTO_FISSO(PHI,X0,TOL,KMAX)
   %   restituisce anche il numero NITER di iterazioni compiute
% (siccome XVECT(1)=X0, si ha length(XVECT) = NITER + 1). %
it = 0;
xvect(it+1) = x0;
err_estim = tol + 1;
while ( err_estim >= tol && it < kmax ) 
    xvect(it+2) = phi( xvect(it+1) );
    err_estim = abs( xvect(it+2) - xvect(it+1) ); 
    it = it + 1;
end
end