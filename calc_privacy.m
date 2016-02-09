function pri = calc_privacy(p, PUx, PUy)

load 'coverage_area.mat';
pri = 0;
for i = 1:Xgrids
    for j = 1:Ygrids
        d(i,j) = grid_res * sqrt((PUx - i)^2 + (PUy - j)^2);
        pri = pri + d(i,j) * p(i,j);
    end
end