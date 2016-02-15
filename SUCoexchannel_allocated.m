%% Channel allocations to SU considering basic SU coexistence
 % there are 4 channels [1 2 3 4], with PU operating on channel 1
 % our aim to assign these channels to SU forming clusters enabling
 % frequency reuse
 
 clear all;
 clc;
 load 'coverage_area.mat'
 load 'tfigloc.mat'
 load 'boundaries.mat'
 load 'PU_loc.mat'
 filename='chan_assignment.mat';
 tfilename = 'tchan_assignment.mat';
matObj = matfile(filename,'Writable',true);
tmatObj = matfile(tfilename,'Writable',true);
changrid=zeros(Xgrids,Ygrids);
tchangrid=zeros(Xgrids,Ygrids);
ch_alloc=matObj.changrid;
tch_alloc=tmatObj.tchangrid;
channels=[1 2];
for i = 1:Xgrids
    for j = 1:Ygrids
        d(i,j) = grid_res * sqrt((PUx - i)^2 + (PUy - j)^2);
    end
end
changrid = (invhilb(Xgrids)< 0) +1;
tchangrid = (invhilb(Xgrids)<0) +1;

for i = 1:Xgrids
    for j = 1:Ygrids
        if(d(i,j) < r_0)                             
                changrid(i,j)=0;       
        end            
     end
end
changrid(PUx,PUy)=1;


for i = 1:Xgrids
    for j = 1:Ygrids
        if(inpolygon(i,j,x',y'))
                tchangrid(i,j)=0;
        end
     end
end
tchangrid(PUx,PUy)=1;
