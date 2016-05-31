function [ file_list, n_image ] = getFileList( folder )
% This function loads the list of image names in a folder

  r_file=ls(folder);

  n_image=0;

  [ filename, r_file ]= strtok(r_file);

  while (size(r_file)~=[0,0])
      n_image=n_image+1;
      file_list{n_image}=filename;
      [ filename, r_file ] = strtok(r_file);
  end

