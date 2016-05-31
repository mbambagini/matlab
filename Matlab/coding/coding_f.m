function [ total, average ] = coding_f( num )
%CODING_F no sense function
%       the workspace is different
  switch num
    case 1
      m = ones(num);
    case 2
      m = zeros(num);
    otherwise
      m = magic(num);
  end

  total = 0;
  for i=1:num
    col = 1;
    while col <= num
      total = total + m(i, col);
      col = col + 1;
    end
  end
  
  average = total / (num * num);
  
end
