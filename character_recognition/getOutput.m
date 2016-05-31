function output = getOutput( character )
% This function returns the desidered output of a character
% The output is an array with 26 rows
% Only one cell is 1, other cells are 0

  output=( dec2bin( bitshift(1, 25-character), 26 )' ) -48;

