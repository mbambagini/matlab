%% SCript example to load data
%

clear
clc

%% load data
%

fname = 'data.csv';
delimiter = ',';

d = importdata(fname, delimiter);
t = d.data(:,1);
vc = d.data(:,2);
v = d.data(:,3);

%% plot data
%

% figure
figure1 = figure;
% axis
axes1 = axes('Parent',figure1);
hold(axes1,'on');
% plot
hold on
plot(t, vc, 'DisplayName','without noise');
plot(t, v, 'DisplayName','with noise');
hold off
% x-axis label
xlabel('Time');
% y-axis label
ylabel('Signal');
% grid
set(axes1,'XGrid','on','YGrid','on');
% legend
legend(axes1,'show');

%% save data
%

save('data.mat', 't', 'v', 'vc');
