function [errors_table,rates]=C_convergence_test(test_name)
%% [errors_table,rates]=C_convergence_test(test_name)
%==========================================================================
% Error analysis varying the mesh size h 
%==========================================================================
% Example of usage: [errors_table,rates] = C_convergence_test('Test1')
%
%    INPUT:
%          test_name    : (string)  test case name, see C_dati.m
%
%    OUTPUT:
%          errors_table : (struct) containing the computed errors
%          rates        : (struct) containing the computed rates


warning off;
addpath Assembly
addpath BoundaryConditions
addpath Errors
addpath MeshGeneration
addpath FESpace
addpath Postprocessing


Dati = C_dati(test_name);

refinement_vector=Dati.refinement_vector;
num_test=length(refinement_vector);

for k=1:num_test
    ... Solve the problem with the k-th refinement number ...
    [errors,solutions,femregion,Dati] = C_main1D(test_name,refinement_vector(k));

    ... Extract the error values from the obtained output ...
    Error_L2(k)      = errors.Error_L2;
    Error_H1(k)      = errors.Error_H1;
    ne(k)=femregion.ne;    
    h(k)=femregion.h;
    fprintf('==========================================\n');    
    fprintf('End test %i\n',k);
    fprintf('==========================================\n');
end
p=femregion.degree;

%ERROR TABLE
errors_table=struct('ne',ne,...
                   'h',h,...
                   'Error_L2', Error_L2,...
                   'Error_H1', Error_H1);


%RATES TABLE
... Compute the convergence rate estimates ...
rate_L2 = ...
    log10( Error_L2(2:num_test) ./ Error_L2(1:num_test-1) ) ...
    ./ log10( h(2:num_test) ./ h(1:num_test-1) );
rate_H1 = ...
    log10( Error_H1(2:num_test) ./ Error_H1(1:num_test-1) ) ...
    ./ log10( h(2:num_test) ./ h(1:num_test-1) );

rates=struct('rate_L2',rate_L2,...
             'rate_H1',rate_H1);
         

% ERROR PLOTS
... Plot the convergence errors ...
figure

hs = subplot(2,1,1);
loglog(h,h.^(p+1),'-+b','Linewidth',2);
hold on
loglog(h,Error_L2,'-or','Linewidth',2);
hold on
legend(sprintf('h^%i',p+1),'||.||_{L^2}', 'Location','SouthEast');
title ('Errors');
ylabel('L^2-error')
xlabel('h');
hs.FontSize = 12;

hs = subplot(2,1,2);
loglog(h,h.^(p),'-+b','Linewidth',2);
hold on
loglog(h,Error_H1,'-or','Linewidth',2);
hold on
legend(sprintf('h^%i',p),'||.||_{H^1}', 'Location','SouthEast');
ylabel('H^1-error')
xlabel('h');
hold off
hs.FontSize = 12;

 
