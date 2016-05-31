%% Variables
%

clear
clc

% creation
%  [] -> vector/matrix
%  {} -> cell array
% access
% - vector/matrix: () return value
% - cell array: () return cell(s)
% - cell array: {} return content
% - table: () return sub table
% - table: {} return content

%% Scalar: single value
%

x = 3.14;

%% Vector: 1-by-n or m-by-1
%

% object creation
v1 = [1 2 3 4]; % row
v2 = v1'; % column
v3 = [1; 2; 3; 4]; % column
v4 = [1:0.1:10]; % row
v5 = linspace(1, 10, 91); % row
v6 = 'string';
scalar_product = v4*v5'; % the result is scalar

% access
val1 = v3(4);
assert(val1 == 4);

%% Matrix: m-by-n
%

% object creation
m1 = [1 2; 3 4; 5 6; 7 8];
m2 = zeros(4,3);
m3 = [m1 m2]; % concatenation
m4 = m3 * m3';
m5 = sin(m4); % element-by-element
m6 = m5 .* m5'; % element-by-element

% access
val2 = m1(1,2);
assert(val2 == 2);

%% Array: matrix of elements whose type and dimension can be different
%

% not possible to have matrix of strings (they should have the same length)
c1 = {'Milan', 'Rome', 'Pise'; 'Lombardia', 'Lazio', 'Toscana'};
c2 = {'Day', 15, [1 2; 3 4; 5 6]};

% access
val3 = c2{2};
assert(val3 == 15);

%% Table
%

x = linspace(1,10,100);
x = x';
sin_f = sin(x);
cos_f = cos(x);
t = table(x, sin_f, cos_f);
t1 = t(1:10, :); % extract sub-table
t2 = t{1:10, :}; % extract sub-matrix
