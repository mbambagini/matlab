function errValue = errorFun( errPar, x, y, z )
% This function finds the error done
% The error is the number of bad recognition, normalized the total number of 
% elements
% You can use it with trainlm

  if strcmp(errPar, 'pdefaults')
      errValue=struct;
      return;
  end

  errPar=errPar{1,1};
  n_rows=size(errPar,1);
  n_cols=size(errPar,2);
  
  errValue=0;
  
  for i=1:n_cols
      %e=t-y
      y=(-1)*errPar(:,i);
      %e=y-t
      %the max output value is 1
      %after negation the max value is the min value (-1,0]
      [val, I]=min( y );
      %it gets t
      t=zeros(n_rows,1);
      t(I)=1;
      %it gets y
      y=y+t;
      %it finds the winners
      pos=find( compet( y ) ==1 );
      %if this is an error then it notify it
      if(pos~=I)
          errValue=errValue+1;
      end
  end
  errValue=errValue/n_cols;

