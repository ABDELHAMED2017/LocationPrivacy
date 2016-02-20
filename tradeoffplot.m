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

load 'transmetrics.mat'
load 'SidesPolygon'
% load 'Privacytrans'
% load 'SUTrans'
tm_privacy=mean(tm_privacy,1);
size(tm_privacy)
tavg_privacy=tm_privacy(1,:,10)/max(tm_privacy(:));
Spec_Util_Trans=trASC/max(trASC);
%tavg_privacy=tavg_privacy/max(tavg_privacy);

% plot(tavg_privacy,Spec_Util_Trans,'rs--','LineWidth',2,'MarkerSize',5);
% grid on;hold on;
% xlabel('Incorrectness');
% ylabel('Area Sum Capacity');

% figure
% b=bar([ASC_Noise,avg_privacy],.8);
% grid on;
% set(b(2),'facecolor','y'); 
% set(b(1),'facecolor','b'); 
% % b(2).LineWidth=2;
% % b(2).FaceColor='y';
% set(gca,'XTickLabel',{'No noise', '20%', '40%', '60%','80%','100%'})
% title('Specrtum Utilization vs PU Privacy (With Additive noise)');
% legend('ASC','Incorrectness');


plot(avg_privacy,ASC_Noise,'bo--','LineWidth',2,'MarkerSize',6);
% grid on;
% xlabel('Incorrectness');
% ylabel('Area Sum Capacity');
legend('Perturbation w/ transfiguration','Perturbation w/ additive noise');