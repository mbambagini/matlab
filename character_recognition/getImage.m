function [ imm_BW ] = getImage( filename, x_pixels, y_pixels, error )
% This function trasforms an image in a useful data structure
% It loads, deletes colours, reduces and adds noise to the image

  %it reads the image
  imm1 = imread(filename);

  %it adds noise to the image
  if error~=0
      imm1=addNoise(imm1, error);
  end

  %it converts the image in black and white
  imm2=im2bw(imm1,0.4);
  
  %it resizes the image
  imm3=imresize(imm2, [x_pixels, y_pixels]);

  %it reshapes the image matrix in a vector
  imm_BW=reshape(imm3, x_pixels*y_pixels, 1)+0;

