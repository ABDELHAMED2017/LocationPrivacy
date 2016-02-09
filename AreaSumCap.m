function [ASC,tASC] = AreaSumCap(W,zeta,Rot_rate)
%% Parameters for ASC calculation
load 'coverage_area.mat';
load 'databasecalc.mat';
load 'tdatabasecalc.mat';
load 'chan_assignment.mat';
load 'boundaries.mat';
load 'PU_loc';
load 'tfigloc.mat'
ASC=0;
tASC=0;
BandWidth=W;
P_ts=1;
P_loss=.9;
Noise_pow=1e-8;
I_ps=.3;
I_ss=.1;
tau=Rot_rate;
for i = 1:Xgrids
    for j = 1:Ygrids
        d(i,j) = grid_res * sqrt((PUx - i)^2 + (PUy - j)^2);        
    end
end
for i = 1:Xgrids
    for j = 1:Ygrids 
        if(d(i,j) <= r_1)
        if(changrid(i,j)==0)
            chan_pow=0;
            blank_dur=0;
        elseif(changrid(i,j)==2)
            chan_pow=1; 
            blank_dur=0;
        elseif(changrid(i,j)==1)
            chan_pow=1;
            blank_dur=zeta;
        end
        SINR= (P_ts*chan_pow/ P_loss)./(Noise_pow*BandWidth + I_ps + I_ss);
        ASC = ASC + BandWidth* (log2(1 + SINR))* (1- blank_dur/tau); 
        end               
    end
end

for i = 1:Xgrids
    for j = 1:Ygrids 
        if(inpolygon(i,j,X',Y'))
            if(changrid(i,j)==0)
                chan_pow=0;
            elseif(changrid(i,j)==2)
                chan_pow=1; 
                blank_dur=0;
            elseif(changrid(i,j)==1)
                chan_pow=1;
                blank_dur=zeta;
            end
        SINR= (P_ts*chan_pow/ P_loss)./(Noise_pow*BandWidth + I_ps + I_ss);
        tASC = tASC + BandWidth* (log2(1 + SINR))* (1- blank_dur/tau); 
        end               
    end
end


end