function [max_dist, a, b] = getMaxSpread( mainFolder )

  %it loads the image list
  [data_dir, n_dir_image]=getFileList(mainFolder);

  tot=0;
  for i=1:n_dir_image
      [a, b]=getFileList([mainFolder,'/',data_dir(i).file,'/']);
      tot=tot+b-1;
  end

  %it inizializes the data structures
  p=zeros(35, tot);

  pos=1;
  for i=1:n_dir_image
      [pApp, tApp] = getImageSet([mainFolder,'/',data_dir(i).file,'/'], 7, 5, 0);
      p(:,pos:(pos-1+size(pApp,2)))=pApp(:,1:size(pApp,2));
      pos=pos+size(pApp,2);
  end

  max_dist=0;
  a=zeros(35,1);
  b=a;
  %for each image
  for i=1:size(p,2)-1
      for j=i+1:size(p,2)
          app=dist(p(:,i)', p(:,j));
          if app>max_dist
              max_dist=app;
              a=p(:,i);
              b=p(:,j);
          end
      end
  end
  disp(['Max dist: ', num2str(max_dist)]);

