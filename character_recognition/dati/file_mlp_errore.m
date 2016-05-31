function file ( data, p, t )

  Y=zeros(10, 1);
  X=[0.1:0.1:1]';

  for colonna=1:10
      for riga=1:10
          Y(riga, 1) = Y(riga, 1) + evaluateNetwork(data{colonna, riga}.network, p,t);%data{colonna, riga}.err_tr;
%          Y(riga, 2) = Y(riga, 2) + data{colonna, riga}.err_te;

      end
  end

  for indice=1:10
      Y(indice, 1) = Y(indice, 1) / 10;
%      Y(indice, 2) = Y(indice, 2) / 10;
  end
  
  bar(X,Y,'group')
  title('Errore sui caratteri senza disturbo');
  xlabel('Indice di errore');
  ylabel('Errore percentuale');
%  h = legend('Errore training set','Errore testing set',2);
%  set(h,'Interpreter','none')
