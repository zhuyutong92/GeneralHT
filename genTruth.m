function [ x, y ] = genTruth( center_x, center_y, w, l, ori, resolution )
    tmp = squareTmp(l, w, resolution);
    x = zeros(size(tmp, 1), 1);
    y = zeros(size(tmp, 1), 1);
    for i = 1 : size(tmp, 1)
        x(i) = tmp(i, 1) * cos(tmp(i, 2) + ori) + center_x;
        y(i) = tmp(i, 1) * sin(tmp(i, 2) + ori) + center_y;
    end
end