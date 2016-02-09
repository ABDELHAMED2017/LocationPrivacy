%% Clear all variables and clean screen
clear all;
close all;
clc;

%% Outer loop to run the experiment N times
Trials=20;
maxqueries=25;
R_0=50;
R_1=110;
avg_pri=zeros(Trials,maxqueries+1);
tavg_pri=zeros(Trials,maxqueries+1);
ASC=zeros(1,Trials);
tASC=zeros(1,Trials);
for l=1:Trials
    l
%% Initialize parameters
k = 1;                      %attacker's knowledge of the total number of PUs
load 'coverage_area.mat';   %Read total grids and distance between grids form file
load 'PU_loc.mat';
load 'boundaries.mat'
load 'tfigloc.mat'

%% Initialize inference probability
p = k/(Xgrids*Ygrids)*ones(Xgrids,Ygrids);
tp = k/(Xgrids*Ygrids)*ones(Xgrids,Ygrids);
%p = 0.5*ones(Xgrids,Ygrids);
%% Make multiple queries i.e., Launch the inference attack
%r_0=30;
%r_1=110;
privacy(1) = calc_privacy(p, PUx, PUy);
tprivacy(1) = calc_privacy(tp, PUx, PUy);
queries_x = zeros(maxqueries,1);
queries_y = zeros(maxqueries,1);

SU_loss_total = 0;
%% params for ASC
zeta=2;
tau=4;
BandWidth=5e6;

%ASC(1)=AreaSumCap(BandWidth,zeta,tau);

for curr_query = 1:maxqueries
    %% Generate random query location
    [query_x, query_y] = findquerylocation(queries_x,queries_y);
    %fprintf('Query (%d) from: %d\t%d\n',curr_query,query_x,query_y);
    queries_x(curr_query) = query_x;
    queries_y(curr_query) = query_y;

    %% Query the GDB
    SAS_response = gdb(query_x, query_y);
    [tChan_alloc,Chan_alloc]=channel_allocated(query_x,query_y);
    fprintf('Query (%d) from: %d\t%d\t%d\t%d\n',curr_query,query_x,query_y,Chan_alloc,tChan_alloc);
    Tx_power = SAS_response.actual_pow;
    Blanking_dur = SAS_response.actual_blank;
    tTx_power = SAS_response.perturbed_pow;
    tBlanking_dur = SAS_response.perturbed_blank;
    SU_loss_total = SU_loss_total + (Chan_alloc - tChan_alloc); 
    
    
    %% Initialize flags (1 for all the probable PU grids)
    flag = zeros(Xgrids,Ygrids);
    tflag = zeros(Xgrids,Ygrids);
    %% Calculate total path loss = free space path loss
    for i = 1:Xgrids
        for j = 1:Ygrids
            d(i,j) = grid_res * sqrt((query_x - i)^2 + (query_y - j)^2);
        end
    end

    %% Flag probable PU grids based on received power and total path loss
    cntflag_up = 0; %count probable PU grids
    tcntflag_up=0;
    if (Tx_power == 0 && Chan_alloc==0)
        for i = 1:Xgrids
            for j = 1:Ygrids
                if(d(i,j) <= R_0 && p(i,j) ~= 0)
                    flag(i,j) = 1; %PU might be in this grid
                    cntflag_up = cntflag_up + 1;
                end
            end
        end
    elseif (Tx_power == 1 && Blanking_dur==1 && Chan_alloc== 1)
        for i = 1:Xgrids
            for j = 1:Ygrids
                if(d(i,j) > R_0 && d(i,j) <= R_1 && p(i,j) ~= 0)
                    flag(i,j) = 1; %PU might be in this grid
                    cntflag_up = cntflag_up + 1;
                end
                if(d(i,j) <= R_0 && p(i,j) ~= 0)
                    p(i,j) = 0; %No PU in this grid
                end
            end
        end
        
%    elseif(Tx_power ==1 && Chan_alloc==2)
%        %fprintf('Im here');
%         for i = 1:Xgrids
%             for j = 1:Ygrids                
%                     if(d(i,j) > r_0 && d(i,j) <= r_1 && p(i,j) ~= 0)
%                         flag(i,j) = 1; %PU might be in this grid
%                         cntflag_up = cntflag_up + 1;
%                     end
%                     if(d(i,j) <= r_0 && p(i,j) ~= 0)
%                          p(i,j) = 0; %No PU in this grid
%                     end
%             end
%         end
        
    elseif(Tx_power ==1 &&  Blanking_dur==0 && Chan_alloc==1)
        for i = 1:Xgrids
            for j = 1:Ygrids                
                    if(d(i,j) <= R_1)
                        p(i,j)=0;                  
                    end
            end
        end
   end
%% Probability update for the transfigured shape
if (tTx_power == 0 && tChan_alloc==0)
        for i = 1:Xgrids
            for j = 1:Ygrids
                if(d(i,j) <= R_0 && tp(i,j) ~= 0)
                    tflag(i,j) = 1; %PU might be in this grid
                    tcntflag_up = tcntflag_up + 1;
                end
            end
        end
    elseif (tTx_power == 1 && tBlanking_dur==1 && tChan_alloc== 1)
        for i = 1:Xgrids
            for j = 1:Ygrids
                if(d(i,j) > R_0 && d(i,j) <= R_1 && tp(i,j) ~= 0)
                    tflag(i,j) = 1; %PU might be in this grid
                    tcntflag_up = tcntflag_up + 1;
                end
                if(d(i,j) <= R_0 && tp(i,j) ~= 0)
                    tp(i,j) = 0; %No PU in this grid
                end
            end
        end
        
%    elseif(Tx_power ==1 && Chan_alloc==2)
%        %fprintf('Im here');
%         for i = 1:Xgrids
%             for j = 1:Ygrids                
%                     if(d(i,j) > r_0 && d(i,j) <= r_1 && p(i,j) ~= 0)
%                         flag(i,j) = 1; %PU might be in this grid
%                         cntflag_up = cntflag_up + 1;
%                     end
%                     if(d(i,j) <= r_0 && p(i,j) ~= 0)
%                          p(i,j) = 0; %No PU in this grid
%                     end
%             end
%         end
        
    elseif(tTx_power ==1 &&  tBlanking_dur==0 && tChan_alloc==1)
        for i = 1:Xgrids
            for j = 1:Ygrids                
                    if(d(i,j) <= R_1)
                        tp(i,j)=0;                  
                    end
            end
        end
end
%% Update inference probabilities
    for i = 1:Xgrids
        for j = 1:Ygrids
            if (flag(i,j) == 1) %Update all probable grids
                temp = p(i,j);
                p(i,j) = temp/(1-1/cntflag_up*(1-temp));
            end
        end
    end
    %% update inference for transfigured
        
    for i = 1:Xgrids
        for j = 1:Ygrids
            if (tflag(i,j) == 1) %Update all probable grids
                temp = tp(i,j);
                tp(i,j) = temp/(1-1/tcntflag_up*(1-temp));
            end
        end
    end
%     if(max(max(p)) == 1)
%         [PU_found_x, PU_found_y] = find(p == 1);
%         for i = 1:length(PU_found_x)
%             noPUwithin_d = d(PU_found_x(i),PU_found_y(i));
%             p(noPUwithin_d <= r_1) = 0;
%         end
%     end
    updated_p_after_each_response(curr_query) = {p};
    privacy(curr_query+1) = calc_privacy(p, PUx, PUy);
    tprivacy(curr_query+1) = calc_privacy(tp, PUx, PUy);
    
end
SU_loss_average = SU_loss_total/maxqueries;
avgpri(l,:)=privacy;
tavgpri(l,:)=tprivacy;
[ASC(l), tASC(l)]= AreaSumCap(BandWidth,zeta,tau);
end

figure(1)
avg_pri=mean(avgpri);
tavg_pri=mean(tavgpri);
%ASC=ASC;
%tASC=tASC;
plot(0:curr_query,avg_pri/max(avg_pri),'-b*','LineWidth',2);
hold on;
plot(0:curr_query,tavg_pri/max(tavg_pri),'--r*','LineWidth',2);
max_privacy=max(privacy);
%max_privacy=1;
figure(2)  
hold on; grid on;
plot(0:curr_query,privacy/max_privacy,'-b*','LineWidth',2);
xlabel('Query #','FontSize',14);
ylabel('Incorrectness','FontSize',14);
title('PU privacy','FontSize',14);
figure(3)
grid on; hold on;
colormap('Summer');   % set colormap
imagesc(p);        % draw image and scale colormap to values range
colorbar;% show color scale
xlabel('Xgrids');
ylabel('Ygrids');
title('Adversary estimate after 50 Queries (With perturbation)');
%figure(3)
%plot(0:curr_query,ASC/max(ASC));