%% SU with additive noise
clear all;
close all;
clc;
load 'noisedmetrics.mat'
load 'AdditiveBoundar'
%mean_su=mean(m_util,2);
%mean_su=mean_su/max(mean_su);
%max(m_util,[],2)
avg_privacy=m_privacy(:,10)/max(m_privacy(:));
ASC_Noise=ASC_Noise/max(ASC_Noise);


figure
b=bar([ASC_Noise,avg_privacy],.8);
grid on;
set(b(2),'facecolor','y'); 
set(b(1),'facecolor','b'); 
% b(2).LineWidth=2;
% b(2).FaceColor='y';
set(gca,'XTickLabel',{'No noise', '20%', '40%', '60%','80%','100%'})
title('Specrtum Utilization vs PU Privacy (With Additive noise)');
legend('ASC','Incorrectness');

% figure
% plot(avg_privacy,ASC_Noise,'-b^','LineWidth',2,'MarkerSize',6);
% grid on;
% xlabel('Incorrectness');
% ylabel('Area Sum Capacity');
% legend('Perturbation w/ additive noise');