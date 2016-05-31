%% clean up
%

clear
clc

%% create input
%

m = magic(10); % 10x10 matrix
v = reshape(m, [100,1]); % reshape as 100x1 vector

%% find positions with elements higher than 50
%

matrix = v > 50;

%% find indexes with elements higher than 50
%

idx = find(v > 50); % return indexes which satify the constraint
values = v(idx); %return values higher than 50
