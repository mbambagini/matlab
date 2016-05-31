function [ imageList, n_image ] = getFileList( folder )
% This function loads the list of image names in a folder

  r_file=ls(folder);

  n_image=0;

  [ data.file, r_file ]= strtok(r_file);

  while (size(r_file)~=[0,0])
      if data.file(1)~=upper(data.file(1))
          continue
      end
      n_image=n_image+1;
      data.output = data.file(1)-65; %min: 0, max 25
      imageList(n_image)=data;
      [ data.file, r_file ] = strtok(r_file);
  end

