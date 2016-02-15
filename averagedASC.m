%% calculating ASC with different orientations with transfiguration
% make sure SidesPolygon is not commented in the generatepowermap
clear all;
clc;
Npoly=4;
Trials=5;
trASC=zeros(7,Trials);
rw=1;
cl=1;
save('SidesPolygon','Npoly','Trials','trASC','rw','cl');
%BW=5e6;
%Tau=4;
%Zeta=2;
for p=1:7
    fprintf('Reached here');
    p
    load SidesPolygon;      
    for q=1:Trials
        fprintf('Otther trial')
        q
        generatepowermap
        load SidesPolygon
        [k,trASC(rw,cl)]= AreaSumCap(5e6,2,4);
        cl=cl+1;
        save('SidesPolygon','Npoly','Trials','trASC','rw','cl');
    end
    cl=1;
    rw=rw+1;
    Npoly=Npoly+1;
    save('SidesPolygon','Npoly','Trials','trASC','rw','cl');
    
end
%save('SpectrumUtil','tASC');