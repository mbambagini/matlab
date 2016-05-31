disp('Simple exampe about programming in Matlab');
num = input('Type a number in [1, 20]: ');

if num < 1
    error('the number is too small');
elseif num > 20
    error('the number is too big');
else
    disp('the input is valid');
end

[t, a] = coding_f(num);

disp(['Sum: ', num2str(t)]);
disp(['Avg: ', num2str(a)]);