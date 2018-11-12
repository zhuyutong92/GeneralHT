function [ x, y ] = squareCenter( r, a, ori )
    x = r * cos(a + ori);
    y = r * sin(a + ori);
end

