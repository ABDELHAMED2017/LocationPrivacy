%%Spectrum utilization ssequential queries
clear;
clc;

[I,J]=ind2sub([150,150],randperm(22500));
for i=1:22500
    [~,~]= channel_allocated(I(i),J(i));
end
areasumcaptrans=AreaSumCap(5e6,2,4);
