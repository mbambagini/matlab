function [ p, t, pTest, tTest ] = getImageSetCV( folder, x, y, indCv, error )
% This function generates the set from all images in a folder

  %it loads the image list
  [data_dir, n_dir_image]=getFileList(folder);

  tot=0;
  minNum=1000;
  for i=1:n_dir_image
      [a, b]=getFileList([folder,'/',data_dir(i).file,'/']);
      minNum=min(minNum,b);
      tot=tot+b-1;
  end

  if minNum<indCv
      disp('Error in indCv range')
      p=0; t=0; pTest=0; tTest=0;
      return;
  end
  
  %it inizializes the data structures
  t=zeros(26, tot);
  p=zeros(x*y, tot);

  pos=1;
  for i=1:n_dir_image
      if nargin<5 %without noise
          error=0;
      end
      [pApp, tApp] = getImageSet([folder,'/',data_dir(i).file,'/'], x, y, error);
      if indCv~=1
          p(:,pos:(pos+indCv-2))=pApp(:,1:indCv-1);
          t(:,pos:(pos+indCv-2))=tApp(:,1:indCv-1);
          pos=pos+indCv-1;
      end
      if indCv~=10
          p(:,pos:(pos+size(pApp,2)-indCv-1))=pApp(:,indCv+1:size(pApp,2));
          t(:,pos:(pos+size(tApp,2)-indCv-1))=tApp(:,indCv+1:size(tApp,2));
          pos=pos+size(pApp,2)-indCv;
      end
      pTest(:,i)=pApp(:,indCv);
      tTest(:,i)=tApp(:,indCv);
  end

