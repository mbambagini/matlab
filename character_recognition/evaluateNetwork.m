function nError = evaluateNetwork( net, p, t )
% This function computes the percentual error on a data set

  nError=0;
  for i=1:size(p,2)
      pos1=find( compet(sim(net, p(:,i))) ==1 );
      pos2=find( t(:,i) ==1 );
      if(pos1~=pos2)
          nError=nError+1;
%          disp(['Ha letto ', char(pos1+64), ' invece di ', char(pos2+64)])
      end
  end
  nError=(nError*100)/size(p,2);

