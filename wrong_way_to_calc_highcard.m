function index = wrong_way_to_calc_highcard(i,j)
%WRONG_WAY_TO_CALC_HIGHCARD Summary of this function goes here
%   Detailed explanation goes here
if i == 1
    if j == 1
        index = 2;
    elseif j == 2
        index = 3;
    elseif j == 3
        index = 4;
    elseif j == 4
        index = 5;
    else
        index = 6;
    end
elseif i == 2
    if j == 7
        index = 3;
    elseif j == 8
        index = 4;
    elseif j == 9
        index = 5;
    else
        index = 6;
    end
elseif i == 3
    if j == 12
        index = 4;
    elseif j == 13
        index = 5;
    else
        index = 6;
    end
elseif i == 4
    if j == 16
        index = 5;
    else
        index = 6;
    end
else
    index = 6;
end

