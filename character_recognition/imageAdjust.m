function imageAdjust( folder_src, folder_dst )
% This function scans a source folder, applies 'imcrop' at all images and 
% restore them

  [imageList, nImages]=getImageList(folder_src);

  for image=1:nImages
      imm=imread([folder_src,'/',imageList(image).file]);
      for num=1:4 %for each side
          trovato=0;
          switch num
              case 1 %first column
                  i_in=1; i_fin=size(imm,1); j_in=1; j_fin=size(imm,2); passo=1;
              case 2 %first row
                  i_in=1; i_fin=size(imm,2); j_in=1; j_fin=size(imm,1); passo=1;
              case 3 %last column
                  i_fin=1; i_in=size(imm,1); j_fin=1; j_in=size(imm,2); passo=-1;
              case 4 %last row
                  i_fin=1; i_in=size(imm,2); j_fin=1; j_in=size(imm,1); passo=-1;
          end
          for j=j_in:passo:j_fin
              for i=i_in:passo:i_fin
                  if num==1 || num==3
                      check=imm(i,j);
                  else
                      check=imm(j,i);
                  end
                  if check<=180
                      trovato=1;
                      break
                  end
              end
              if trovato==1
                  break
              end
          end
          switch num
              case 1 %it checks the first column
                  x_min=j;
              case 2 %it checks the first row
                  y_min=j;
              case 3 %it checks the last column
                  width=(j-x_min);
              case 4 %it checks the last row
                  height=(j-y_min);
          end
      end
      %it modifies and restores the image
      imm2=imcrop(imm, [x_min, y_min, width, height]);
      imm3=imresize(imm2, [70, 50]);
      imwrite(imm3, [folder_dst,'/',imageList(image).file]);
  end

