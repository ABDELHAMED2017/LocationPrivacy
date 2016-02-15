%% SU with additive noise
clear all;
clc;
load 'noisedmetrics.mat'
load 'AdditiveBoundar'
%mean_su=mean(m_util,2);
%mean_su=mean_su/max(mean_su);
%max(m_util,[],2)
avg_privacy=m_privacy(:,26)/max(m_privacy(:));
ASC_Noise=ASC_Noise/max(ASC_Noise);
%Spec_Util_Noise=mean(ASC_Noise,2);
%avg_privacy=avg_privacy/max(avg_privacy);
figure
b=bar([ASC_Noise',avg_privacy],.6);
set(b(2),'facecolor','y'); 
set(b(1),'facecolor','b'); 
% b(2).LineWidth=2;
% b(2).FaceColor='y';
set(gca,'XTickLabel',{'No noise', '15%', '30%', '45%','60%','75%','90%'})
title('Specrtum Utilization vs PU Privacy (With Additive noise)');
legend('Spectrum utilization','PU privacy');