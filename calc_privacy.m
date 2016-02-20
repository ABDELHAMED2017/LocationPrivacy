function pri = calc_privacy(p, PUx, PUy)

load 'coverage_area.mat';
load 'chan_assignment';
load 'tchan_assignment';
pri = 0;
for i = 1:Xgrids
    for j = 1:Ygrids
        d(i,j) = grid_res * sqrt((PUx - i)^2 + (PUy - j)^2);
        %if(changrid(i,j)== 1 || changrid(i,j)== 2)
        pri = pri + d(i,j) * p(i,j);
        %end
    end
end