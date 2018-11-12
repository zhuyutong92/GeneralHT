function [ template ] = squareTmp( length, width, angle_resolution )
    template = zeros(ceil(2 * pi / angle_resolution), 2);
    corner_angle = atan(width / length);
    i = 0;
    for a = -pi : angle_resolution : pi
        i = i + 1;
        template(i, 2) = a; % angle
        if abs(a) <= corner_angle || abs(a) >= pi - corner_angle
            template(i, 1) = abs((length / 2) / cos(a)); % range
        else
            template(i, 1) = abs((width / 2) / sin(a)); % range
        end
    end
end

