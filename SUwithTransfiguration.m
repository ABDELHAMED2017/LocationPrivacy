%% SU with transfiguration noise
clear all;
clc;
load 'transmetrics.mat'
tmean_su=mean(tm_util,2);
tmean_su=tmean_su/max(tmean_su);
%max(m_util,[],2)
tavg_privacy=tm_privacy(:,26);
tavg_privacy=tavg_privacy/max(tavg_privacy);
figure
bar([tmean_su,tavg_privacy]);
title('Comparision of SU vs PU privacy');
legend('Spectrum utilization','SU privacy');