%% SU with additive noise
clear all;
clc;
load 'noisedmetrics.mat'
mean_su=mean(m_util,2);
mean_su=mean_su/max(mean_su);
%max(m_util,[],2)
avg_privacy=m_privacy(:,26);
avg_privacy=avg_privacy/max(avg_privacy);
figure
bar([mean_su,avg_privacy]);
title('Comparision of SU vs PU privacy');
legend('Spectrum utilization','SU privacy');