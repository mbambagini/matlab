%% clean up
%

close all
clear
clc

%% datetime type
%

% 3rd May 2015
t1 = datetime(2016, 5, 3);

% 3rd June 2015
t2 = datetime(2016, 6, 3);

%% duration type
% elapsed time without considering calendar - time interval in hours
% minutes and seconds

% 3h 15' 45"
d1 = duration(2, 15, 45);

%% calendarDuration type
% elapsed time without considering calendar - time interval in years months
% and days

% 1 year, 5 months and 15 days
c1 = calendarDuration(1, 5, 15);

%% Arithmetic
%

% datetime - datetime = duration
res1 = t2 - t1;

% between(datetime, datetime) = calendarDuration (considing leap years)
res2 = between(t2,t1);

% datetime + (duration, calendarDuration, scalar) = datetime
res3 = t2 + d1;

% duration + (duration, scaler) = duration
res4 = d1 + 10;

% calendarDuration + (calendarDuration, scaler) = calendarDuration
res5 = c1 + 10;

% scaling
res6 = d1 * 4; % duration
res7 = c1 * 4; % calendarDuration

%% Extract data
%

res8 = seconds(d1);
res9 = month(t1);
% ...
