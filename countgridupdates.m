function count = countgridupdates(p, temp_p)

count = 0;

for i = 1:size(p,1)
    for j = 1:size(p,2)
        if p(i,j) ~= temp_p(i,j)
            count = count + 1;
        end
    end
end