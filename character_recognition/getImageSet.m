function [ p, t ] = getImageSet( folder, x, y, error )
% This function generates the set from all images in a folder

  %it loads the image list
  [data, n_image]=getFileList(folder);

  %it inizializes the data structures
  t=zeros(26, n_image);
  p=zeros(x*y, n_image);

  for i=1:n_image
      if nargin<4 %without noise
          error=0;
      end
      %input
      p(:, i) = getImage([folder,'/',data(i).file], x, y, error);
      %putput
      t(:, i)=getOutput(data(i).output);
  end

