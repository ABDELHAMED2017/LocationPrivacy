%% calculating ASC with different noises
% boundaries.mat to be commented in generatepowermap

clear all;
clc;
ASC_Noise=zeros(1,7);
cl=1;
r_0=50;
r_1=110;
save('AdditiveBoundar.mat','ASC_Noise','r_0','r_1','cl');

for p=1:7
    %load AdditiveBoundar.mat  
    generatepowermap
    load 'AdditiveBoundar.mat'
    [ASC_Noise(cl),k]= AreaSumCap(5e6,2,4);
    cl=cl+1;
    r_0=r_0 + 50*0.15;
    r_1=r_1 + 110*0.15;
    save('AdditiveBoundar.mat','ASC_Noise','r_0','r_1','cl');   
end
%save('SpectrumUtil','tASC');