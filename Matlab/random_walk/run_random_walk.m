
num_steps = 1000000;
max_x_step = 2;
max_y_step = 2;
[x,y] = random_walk(num_steps, max_x_step, max_y_step);

plot(x,y)
clear num_steps max_x_step max_y_step
clear x y