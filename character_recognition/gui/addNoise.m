function imm = addNoise( imm, errorValue )
% This function adds some noise to an image
% The input parameter, error, indicates the percentual of bits to modify
% The function randomizes a coordinate and chooses a new value
% The new value can be white or black
% Parameters:
% imm : original image
% errorValue: percentual noisy intensity
% It returns the image with noise

  %7:1=size(imm,1):x
  %5:1=size(imm,2):y
  factor_x = round((size(imm,1))/7);
  factor_y = round((size(imm,2))/5);

  %35:nBits=100:ErrorValue*100
  nBits= floor( 35*errorValue );

  values=[0 255];

  for i=1:nBits
      %it rands the position and the new value
      x=randint(1, 1, [1, size(imm, 1)-factor_x]);
      y=randint(1, 1, [1, size(imm, 2)-factor_y]);
      val=randint(1,1,[1,2]);

      %it modifies the image
      for i=x:x+factor_x-1
          for j=y:y+factor_y-1
              imm(i,j,1)=values(val);
              imm(i,j,2)=values(val);
              imm(i,j,3)=values(val);
          end
      end
  end

