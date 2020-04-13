function [x, y] = random_walk(num_steps, max_x_step, max_y_step)

x = zeros(1, num_steps);
y = zeros(1, num_steps);
x(1) = 0;
y(1) = 0;
for i = 2:num_steps
    x(i) = x(i-1) + randi([-max_x_step, max_x_step]);
    y(i) = y(i-1) + randi([-max_y_step, max_y_step]);
end
