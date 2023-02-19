% Con FEM4MI tocco solo Eser_main1D e Eser_dati.m
clc;
clear all;
close all;
nRef=5; % numero di raffinamenti chiesti dal testo
TestName='Es3';
% risolve il sistema lineare col FEM4MI
[errors,solutions,femregion,Dati]=Eser03_main1D(TestName,nRef)
% Ho confrontato i vari tempi di esecuzione coi 3 metodi backslash, lu,
% cholesky: TEMPI: backslash<chol<lu