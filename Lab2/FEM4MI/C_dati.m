%=======================================================================================================
% This contain all the information for running main
% TEMPLATE OF THE STRUCT DATI
%=======================================================================================================
%
%  DATI= struct( 'name',              % set the name of the test 
%                'Domain',            % set the domain [x1,x2]
%                'mu',                % set the diffusion coefficient
%                'beta',              % set the advection coefficient
%                'force',             % set the forcing term
%                'exact_sol',         % set the exact solution
%                'grad_exact',        % set the derivative of the exact solution
%                'fem',               % set finite element space
%                'nqn_1D',            % number of quadrature nodes for integrals over lines
%                'refinement_vector', % set the level of refinement for the grid
%                'visual_graph',      % if you want to display the graphical results ['Y','N']
%                'visual_exact',      % if you want to display also the exact solution ['Y','N']
%                'plot_errors'        % you want to print the computed errors ['Y','N']
% 
%========================================================================================================

function [Dati]=C_dati(test)

if strcmp(test, 'Test1')
Dati = struct( 'name',             test,...
               ... % Test name
               'domain',           [0,pi],...                          
               ... % Domain bounds       
               'mu',               1, ...
               ... % Diffusive term ...
               'beta',             0, ...
               ... % Advective term ...
               'force',            'sin(x)',...  
               ... % Forcing term
               'exact_sol',        'sin(x)',...      
               ... % Definition of exact solution
               'grad_exact',       'cos(x)',...    
               ... % Definition of exact gradient (x comp) 
               'fem',              'P1',...         
               ... % P1-fe
               'nqn_1D',            2,...           
               ... % Number of quad. points per element
               'MeshType',         'TS', ...        
               ... % Triangular Structured mesh
               'refinement_vector', [2:6],...   
               ... % Refinement levels for  the error analysis
               'visual_graph',      'Y',...
               ... % Visualization of the solution
               'visual_exact',      'Y',...
               ... % Visualization of the exact solution
               'plot_errors',       'Y' ...
               ...% Compute Errors 
               );
end



