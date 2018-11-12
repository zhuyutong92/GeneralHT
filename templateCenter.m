function [ center ] = templateCenter( x, y, ori, template )
    center = zeros(size(template, 1), 2);
    for i = 1 : size(template,1)
        r = template(i, 1);
        a = template(i, 2);
        disp_x = - r * cos(a + ori);
        disp_y = - r * sin(a + ori);
        center(i, 1) = x + disp_x;
        center(i, 2) = y + disp_y;
    end
end

