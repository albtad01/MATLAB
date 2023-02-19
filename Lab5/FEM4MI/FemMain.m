clc
clear all
close all
for nRef=[5,6,7]
    [errors,solutions,femregion,Dati]=C_main1D('Test1',nRef)
    hold on
end