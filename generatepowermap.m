clear all;
%% Initialize the required variables
load 'coverage_area.mat';
load 'boundaries.mat'
%load 'SidesPolygon.mat'

load 'AdditiveBoundar.mat';
Nside_poly=8;
d = zeros(Xgrids, Ygrids);
totpathloss = zeros(Xgrids, Ygrids);
Rxpower = zeros(Xgrids, Ygrids);
changrid=(invhilb(Xgrids)<0)+1; %zeros(Xgrids,Ygrids);
tchangrid=(invhilb(Xgrids)<0)+1;%zeros(Xgrids,Ygrids);
pow = zeros(Xgrids, Ygrids);
tpow = zeros(Xgrids, Ygrids);
blank=zeros(Xgrids,Ygrids);
tblank=zeros(Xgrids,Ygrids);
%Load PU grid location from database
load 'PU_loc.mat'; 


[x,y,X,Y]=Transfiguration(Nside_poly,r_0,r_1);

%Calculate free space path loss from PU to each grid
f = 3.5e9;      %operating frequency
c = 3e8;        %speed of EM wave

for i = 1:Xgrids
    for j = 1:Ygrids
        d(i,j) = grid_res * sqrt((PUx - i)^2 + (PUy - j)^2);
    end
end

%Allocate power values based on path loss at different grids
for i = 1:Xgrids
    for j = 1:Ygrids
        if(d(i,j) > r_0)
             if(d(i,j) > r_1)
                pow(i,j)=1;
                blank(i,j)=0;
                %changrid(i,j)=channels(2); %randi([0 1]);
            else
                pow(i,j)= 1;%round(rand()+0.3);
                blank(i,j)=1;
                %changrid(i,j)=channels(1);
             end            
        else
            pow(i,j)=0;
            blank(i,j)=1;
            changrid(i,j)=0;
        end
     end
end

changrid(PUx,PUy)=1;

%% Power, blanking and channel allocation for transfigured region
for i = 1:Xgrids
    for j = 1:Ygrids
        if(~inpolygon(i,j,x',y'))
             if(~inpolygon(i,j,X',Y'))
                tpow(i,j)=1;
                tblank(i,j)=0;
                %tchangrid(i,j)=channels(2);
            else
                tpow(i,j)= 1;%round(rand()+0.3);
                tblank(i,j)=1;
                %tchangrid(i,j)= channels(1);
                
             end            
        else
            tpow(i,j)=0;
            tblank(i,j)=1;
            tchangrid(i,j) = 0;
        end
     end
end
tchangrid(PUx,PUy)=1;


%% Save power profile and shadowing profile
save('chan_assignment.mat','changrid');
save('tchan_assignment.mat','tchangrid');
%tm= matfile('tchan_assignment','Writable',true);
save('databasecalc.mat','pow','blank');
save('tdatabasecalc.mat','tpow','tblank');
save('tfigloc.mat','x','y','X','Y');
%m.changrid=changrid;
%tm.tchangrid=tchangrid;