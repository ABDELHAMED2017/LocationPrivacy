i=1:2;
m=71;
load 'metrics.mat'
for k=1:length(i)
    k
    querier
    privacy
   % pause
    avgpri(k,:)= privacy;
    save('metrics.mat','avgpri');
end
avgpri
avg_pri=mean(avgpri);
plot(0:70,avg_pri/max(avg_pri));
