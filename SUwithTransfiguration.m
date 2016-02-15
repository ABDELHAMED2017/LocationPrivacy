%% SU with transfiguration noise
clear all;
clc;
load 'transmetrics.mat'
load 'SidesPolygon'
%tmean_su=mean(tm_util,2);
%tmean_su=tmean_su/max(tmean_su);
%max(m_util,[],2)
tavg_privacy=tm_privacy(:,26)/max(tm_privacy(:));
Spec_Util_Trans=mean(trASC,2);
%tavg_privacy=tavg_privacy/max(tavg_privacy);
figure
b=bar([Spec_Util_Trans,tavg_privacy]);
set(b(2),'facecolor','y'); 
set(b(1),'facecolor','b'); 
title('Spectrum Util vs Privacy (with transfiguration)');
set(gca,'XTickLabel',{'N=4', 'N=5', 'N=6', 'N=7','N=8','N=9','N=10'})
legend('Spectrum utilization','PU privacy');