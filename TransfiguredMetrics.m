clear all;
clc;
N=4;
tm_privacy=zeros(N,26);
tm_util=zeros(N,20);
cnt=0;
save('transmetrics.mat','tm_privacy','tm_util','cnt');
for g=1:N
    r_0=50;
    r_1=110;
    Npoly=2*(g-1)+3;
    save('boundaries','r_0','r_1','Npoly');
    generatepowermap
    querier
    load 'transmetrics.mat'
    tm_privacy(cnt+1,:)=tavg_pri;
    tm_util(cnt+1,:)=tASC;
    cnt=cnt+1;    
    save('transmetrics.mat','tm_privacy','tm_util','cnt');
end

load 'transmetrics.mat'
plot(0:25,tm_privacy(1,:)/max(tm_privacy(1,:)),'--r*','LineWidth',2);
hold on;
grid on;
plot(0:25,tm_privacy(2,:)/max(tm_privacy(2,:)),'--b*','LineWidth',2);
plot(0:25,tm_privacy(3,:)/max(tm_privacy(3,:)),'--g*','LineWidth',2);
plot(0:25,tm_privacy(4,:)/max(tm_privacy(4,:)),'--c*','LineWidth',2);
%plot(0:25,tm_privacy(5,:)/max(tm_privacy(5,:)),'--y*','LineWidth',2);
%plot(0:25,tm_privacy(6,:)/max(tm_privacy(6,:)),'--m*','LineWidth',2);
legend('N=3','N=5','N=7','N=9');
xlabel('Number of queries');
ylabel('Privacy (Incorrectness)');
title('Privacy with transfiguration');