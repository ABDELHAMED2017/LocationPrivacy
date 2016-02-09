function [query_x, query_y] = findquerylocation(queries_x,queries_y)

%% Load database parameters
load 'coverage_area.mat'; %Read total grids and distance between grids form file

%% Generate a unique query location
sameflag = 1; %Just to initialize the while loop
while(sameflag == 1)
    sameflag = 0;
    query_x = randi([1, Xgrids]);
    query_y = randi([1, Ygrids]);
    for i = 1:length(queries_x)
        if(queries_x(i) == query_x && queries_y(i) == query_y)
            sameflag = 1;
            break;
        end
    end
end