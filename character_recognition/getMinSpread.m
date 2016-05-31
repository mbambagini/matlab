function getMinSpread( mainFolder )
%type=='e' check characters equal
%type=='s' check spread
%PROVA Summary of this function goes here
%   Detailed explanation goes here

  %it loads all the image folders
  [ folders, n_folders ] = getFileList( mainFolder );

  %it creates the data structures
  equ_cop=0;
  cop=0;
  min_dist=ones(n_folders,1)*1000;
  max_dist=zeros(n_folders,1);
  num_dist=zeros(n_folders,1);
  sum_dist=zeros(n_folders,1);
  equ_dist=zeros(n_folders,1);

  %for each folder
  for z=1:n_folders
%      disp(['start ', folders(z).file])
      local=0;
      folder=[mainFolder,'/',folders(z).file,'/'];
      [ imageList, n_image ] = getFileList( folder );
      %for each image in the folder
      for i=1:n_image-1
          imm_i = getImage([folder,'/',imageList(i).file], 7, 5, 0);
          %for each other images in the folder
          for j=i+1:n_image
              imm_j = getImage([folder,'/',imageList(j).file], 7, 5, 0);
              %it computes the distance
              app=dist(imm_i', imm_j);
              %if the images are equal
              if app==0
%                  equ_dist(imageList(i).output+1)=equ_dist(imageList(i).output+1)+1;
%                  equ_cop=equ_cop+1;
                  local=local+1;
%                  if type=='e'
%                      disp(['uguali  ', imageList(i).file,' ',imageList(j).file])
%                  end
              end
              %it modifies the data structures
              cop=cop+1;
%              sum_dist(imageList(i).output+1)=sum_dist(imageList(i).output+1)+app;
%              num_dist(imageList(i).output+1)=num_dist(imageList(i).output+1)+1;
              sum_dist(z)=sum_dist(z)+app;
              num_dist(z)=num_dist(z)+1;
%              if app>max_dist(imageList(i).output+1)
              if app>max_dist(z)
%                  max_dist(imageList(i).output+1)=app;
                  max_dist(z)=app;
              end
%              if app<min_dist(imageList(i).output+1)
%                  min_dist(imageList(i).output+1)=app;
              if app<min_dist(z)
                  min_dist(z)=app;
              end
          end
      end
%      if type=='e' && local>6
%          pause
%      end
  end

  %it prints information about the characters
  minSpread=1000;
  maxSpread=0;
  sumSpread=0;
  for i=1:n_folders%26
      if min_dist(i)<minSpread
         minSpread=min_dist(i);
      end
      if max_dist(i)>maxSpread
         maxSpread=max_dist(i);
      end
      sumSpread=sumSpread+(sum_dist(i)/num_dist(i));
%      disp(['Lettera: ', char(64+i)]);
      disp(folders(i).file);
%      disp(['Valore minimo: ', num2str(min_dist(i))]);
      disp(['max:', num2str(max_dist(i))]);
      disp(['mean:', num2str((sum_dist(i)/num_dist(i)))]);
%      disp(['Lettere uguali: ', num2str((equ_dist(i)*100/num_dist(i))),'%']);
  end
%  disp(['Numero di coppie uguali: ', num2str(equ_cop)]);
%  disp(['Numero totate di coppie: ', num2str(cop)]);
%  disp(['Minimo spread: ', num2str(minSpread)]);
%  disp(['Massimo spread: ', num2str(maxSpread)]);
%  disp(['Spread medio: ', num2str(sumSpread/73)]);

