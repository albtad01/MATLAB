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

disp('** RICHARDSON **');
A=full(A);
uh = A\b
P=eye(size(A,1));
alpha_opt=2/(max(eig(A))+min(eig(A)));
x0=zeros(size(b,1),1);
tol=1e-12;
nmax=10000;
[x,k]= richardson(A,b, P, x0, tol, nmax, alpha_opt)

disp('** FINE RICHARDSON **');
disp('** INIZIO GRADIENTE **');
P=eye(size(A,1));

if(min(eig(A))>0 & isequal(A,A'))
    disp('A è SDP, quindi il metodo del gradiente converge');
else
    disp('A NON è SDP, quindi il metodo del gradiente NON converge');
end

x0=zeros(size(b,1),1);
tol=1e-12;
nmax=10000;

     [uh, k] = gradiente(A, b, P, x0, 1e-12, 10000);
     disp(['Numero di iterazioni gradiente:',num2str(k)])
disp('** FINE GRADIENTE **')

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



