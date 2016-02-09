function p = update_inference(p, Xgrids, Ygrids, grid_res, resp, query_x, query_y)

Tx_power = resp;

%% Initialize flags (1 for all the probable PU grids)
flag = zeros(Xgrids,Ygrids);

%% Calculate total path loss = free space path loss
for i = 1:Xgrids
    for j = 1:Ygrids
        d(i,j) = grid_res * sqrt((query_x - i)^2 + (query_y - j)^2);
    end
end

%% Flag probable PU grids based on received power and total path loss
cntflag_up = 0; %count probable PU grids
if (Tx_power == 0)
    for i = 1:Xgrids
        for j = 1:Ygrids
            if(d(i,j) <= 1 && p(i,j) ~= 0)
                flag(i,j) = 1; %PU might be in this grid
                cntflag_up = cntflag_up + 1;
            end
        end
    end
elseif (Tx_power == 18)
    for i = 1:Xgrids
        for j = 1:Ygrids
            if(d(i,j) > 1 && d(i,j) <= 2 && p(i,j) ~= 0)
                flag(i,j) = 1; %PU might be in this grid
                cntflag_up = cntflag_up + 1;
            end
            if(d(i,j) <= 1 && p(i,j) ~= 0)
                p(i,j) = 0; %No PU in this grid
            end
        end
    end
else
    for i = 1:Xgrids
        for j = 1:Ygrids
            if(d(i,j) <= 2)
                p(i,j) = 0; %No PU in this grid
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

p = p./sum(sum(p));
end