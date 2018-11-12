clear;

CENTER_X = 10;
CENTER_Y = 10;
LENGTH_X = 4;
WIDTH_Y = 3;
ORIENT = 30 / 180 * pi;
RESOLUTION = 1 / 180 * pi;

ERR_STD_X = 0.2;
ERR_STD_Y = 0.2;
MODEL_LENGTH = 5;
MODEL_WIDTH = 2;
MODEL_ORIENT = 35 / 180 * pi;

GRID_X = 0.2;
GRID_Y = 0.2;
GRID_LEFT = -20;
GRID_RIGT = 20;
GRID_UP = 20;
GRID_DW = -20;

[tx, ty] = genTruth(CENTER_X, CENTER_Y, WIDTH_Y, LENGTH_X, ORIENT, RESOLUTION);
truth = [tx, ty];
measure = genMeasure(truth, [ERR_STD_X, ERR_STD_Y]);

template = squareTmp(MODEL_LENGTH, MODEL_WIDTH, RESOLUTION);
grid = zeros((GRID_UP - GRID_DW) / GRID_X, (GRID_RIGT - GRID_LEFT) / GRID_Y);

for i = 1 : size(measure, 1)
    point = measure(i, :);
    center_points = templateCenter(point(1), point(2), MODEL_ORIENT, template);
    for j = 1 : size(center_points)
        center = center_points(i, :);
        grid_x = round((center(1) - GRID_DW) / GRID_X);
        grid_y = round((center(2) - GRID_LEFT) / GRID_Y);
        grid(grid_x, grid_y) = grid(grid_x, grid_y) + 1;
    end
end

max_val = max(max(grid));
[row, col] = find(grid == max_val);
center(1,1) = row * GRID_X + GRID_DW;
center(1,2) = col * GRID_Y + GRID_LEFT;

rot = [cos(MODEL_ORIENT), sin(MODEL_ORIENT);
      -sin(MODEL_ORIENT), cos(MODEL_ORIENT)];
trans = center';

angle_left_top = MODEL_ORIENT + atan((MODEL_WIDTH/2) / (MODEL_LENGTH/2));
left_top = [cos(angle_left_top), sin(angle_left_top);
            -sin(angle_left_top), cos(angle_left_top)] * [MODEL_LENGTH/2; MODEL_WIDTH/2] + trans;
        
angle_right_top = MODEL_ORIENT + atan((-MODEL_WIDTH/2) / (MODEL_LENGTH/2));
right_top = [cos(angle_right_top), sin(angle_right_top);
            -sin(angle_right_top), cos(angle_right_top)] * [MODEL_LENGTH/2; -MODEL_WIDTH/2] + trans;

angle_left_bottom = MODEL_ORIENT + atan((MODEL_WIDTH/2) / (-MODEL_LENGTH/2));
left_bottom = [cos(angle_left_bottom), sin(angle_left_bottom);
               -sin(angle_left_bottom), cos(angle_left_bottom)] * [-MODEL_LENGTH/2; MODEL_WIDTH/2] + trans;
           
angle_right_bottom = MODEL_ORIENT + atan((-MODEL_WIDTH/2) / (-MODEL_LENGTH/2));
right_bottom = [cos(angle_right_bottom), sin(angle_right_bottom);
               -sin(angle_right_bottom), cos(angle_right_bottom)] * [-MODEL_LENGTH/2; MODEL_WIDTH/2] + trans;

figure(1); scatter(-truth(:,2), truth(:,1), 'b');
figure(1); hold on; scatter(-measure(:,2), measure(:,1), 'g');
figure(1); hold on; line([-left_top(2), -right_top(2)],...
                         [left_top(1), right_top(1)]);
figure(1); hold on; line([-right_top(2), -right_bottom(2)],...
                         [right_top(1), right_bottom(1)]);
figure(1); hold on; line([-right_bottom(2), -left_bottom(2)],...
                         [right_bottom(1), left_bottom(1)]);
figure(1); hold on; line([-left_bottom(2), -left_top(2)],...
                         [left_bottom(1), left_top(1)]);

