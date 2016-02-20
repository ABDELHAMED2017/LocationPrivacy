%% SU with transfiguration noise
clear all;
close all;
clc;
load 'transmetrics.mat'
load 'SidesPolygon'
% load 'Privacytrans'
% load 'SUTrans'
tm_privacy=mean(tm_privacy,1);
size(tm_privacy)
tavg_privacy=tm_privacy(1,:,10)/max(tm_privacy(:));
Spec_Util_Trans=trASC(1:5)/max(trASC);
%tavg_privacy=tavg_privacy/max(tavg_privacy);

% plot(tavg_privacy(1:5),Spec_Util_Trans,'--ro','LineWidth',2,'MarkerSize',5);
% grid on;
% xlabel('Incorrectness');
% ylabel('Area Sum Capacity');

b=bar([Spec_Util_Trans,tavg_privacy(1:5)']);
set(b(2),'facecolor','y'); 
set(b(1),'facecolor','b'); 
grid on;
title('Spectrum Utilization vs Privacy (with transfiguration)');
set(gca,'XTickLabel',{'N=3', 'N=4', 'N=5', 'N=6','N=7','N=8','N=9'})
legend('ASC','Incorrectness');