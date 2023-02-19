function [errors,solutions,femregion,Dati]=C_main1D(TestName,nRef)
%==========================================================================
% Solution of the Poisson's problem with linear finite elements
% (Dirichlet boundary conditions)
%==========================================================================
%
%    INPUT:
%          TestName    : (string)  identifier of the test (see data file)
%          nRef        : (int)     refinement level
%
%    OUTPUT:
%          errors      : (struct) contains the computed errors
%          solutions   : (sparse) nodal values of the computed and exact
%                        solution
%          femregion   : (struct) infos about finite elements
%                        discretization
%          Dati        : (struct)  see data file
%          
% Example of usage: 
%    [errors,solutions,femregion,Dati] = C_main1D('Test1',3)
 


addpath Assembly
addpath BoundaryConditions
addpath Errors
addpath MeshGeneration
addpath FESpace
addpath Postprocessing


%==========================================================================
% LOAD DATA FOR TEST CASE
%==========================================================================

Dati = C_dati(TestName);
Dati.nRefinement = nRef;

%==========================================================================
% MESH GENERATION
%==========================================================================

[Region] = C_create_mesh(Dati);

%==========================================================================
% FINITE ELEMENT REGION
%==========================================================================

[femregion] = C_create_femregion(Dati,Region); 

%==========================================================================
% BUILD FINITE ELEMENT MATRICES and RIGHT-HAND SIDE
%==========================================================================

[A_no_bc,b_no_bc] = C_matrix1D(Dati,femregion);

%==========================================================================
% COMPUTE BOUNDARY CONDITIONS -- MODIFICATION OF A an b
%==========================================================================

[A,b,u_g] = C_bound_cond1D(A_no_bc,b_no_bc,femregion,Dati);

%==========================================================================
% SOLVE THE LINEAR SYSTEM
%==========================================================================

uh = A\b;
% a)
disp('***** ANALISI MATRICE A *****')
A=full(A)
crits1=0;
crits2=0;
if(isbanded(A,1,1)==1) % sotto di 1 banda e sopra di 1 banda
    disp('A tridiagonale')
end
if(A==A')
    disp('A simmetrica')
    crits2=crits2+1;
end
if(eig(A)>0)
    disp('A definita positiva')
    crits2=crits2+2;
end
% Dominanza diagonale (non stretta)
if(diag(abs(A))>=sum(abs(A),1)-diag(abs(A)))
    disp('A DDSC')
    crits1=crits1+1;
end
if(diag(abs(A))>=sum(abs(A),2)-diag(abs(A)))
    disp('A DDSR')
    crits1=crits1+1;
end
% Analisi criteri di convergenza
if(crits1>0)
    disp('J e GS convergono')
else if(crits2==2)
        disp('GS converge')
% ... (criterio tridiagonale e di SOR 0<w<2)
end
end
% b)
D=diag(diag(A));
E=-tril(A,-1);
F=-triu(A,1);
BJ=D\(D-A);
BGS=(D-E)\F;
rhoBJFEM=max(abs(eig(BJ)));
rhoBGSFEM=max(abs(eig(BGS)));
if(rhoBGSFEM-rhoBJFEM<1e-10)
    disp('BJ^2=BGS');
end
% c)
RAPP=(-log(rhoBJFEM))/(-log(rhoBGSFEM))
disp('***** FINE ANALISI *****')
%==========================================================================
% ASSIGN DIRICHLET BOUNDARY CONDITIONS -- through the lifting ug
%==========================================================================

uh = uh + u_g;

%==========================================================================
% POST-PROCESSING OF THE SOLUTION
%==========================================================================

[solutions] = C_postprocessing(Dati,femregion,uh);

%==========================================================================
% ERROR ANALYSIS
%==========================================================================
errors = [];
if (Dati.plot_errors)
    [errors] = C_compute_errors(Dati,femregion,solutions);
end



