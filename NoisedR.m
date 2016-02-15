%% while running this script make sure, boundaries.mat is not commented in
%   generatepowermap. Also see Npoly in generatepowermap
clear all;
clc;
N=7;
m_privacy=zeros(N,26);
m_util=zeros(N,20);
cnt=0;
save('noisedmetrics.mat','m_privacy','cnt');
%asc=AreaSumCap();

for g=1:N
    r_0=50+50*(g-1)*0.15;
    r_1=110+ 110*(g-1)*0.15;
    save('boundaries','r_0','r_1');
    generatepowermap
    querier
    load 'noisedmetrics.mat'
    m_privacy(cnt+1,:)= avg_pri;
    %m_util(cnt+1,:)= ASC;
    cnt=cnt+1;    
    save('noisedmetrics.mat','m_privacy','cnt');
end
load 'noisedmetrics.mat'
figure
plot(0:25,m_privacy(1,:)/max(m_privacy(1,:)),'--r*','LineWidth',2);
hold on;
grid on;
plot(0:25,m_privacy(2,:)/max(m_privacy(2,:)),'--b*','LineWidth',2);
plot(0:25,m_privacy(3,:)/max(m_privacy(3,:)),'--g*','LineWidth',2);
plot(0:25,m_privacy(4,:)/max(m_privacy(4,:)),'--c*','LineWidth',2);
plot(0:25,m_privacy(5,:)/max(m_privacy(5,:)),'--y*','LineWidth',2);
plot(0:25,m_privacy(6,:)/max(m_privacy(6,:)),'--k*','LineWidth',2);
plot(0:25,m_privacy(7,:)/max(m_privacy(7,:)),'--m*','LineWidth',2);
%legend('R1=125','R1=140','R1=160','R1=180','R1=200');
legend('No noise','15%','30%','45%','60%','75%','90%');
xlabel('Number of queries');
ylabel('Privacy (Incorrectness)');
title('Privacy with additive noise');