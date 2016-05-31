function stru = file ( data )

  Y=zeros(10, 1);
  N=zeros(10, 1);

  for indice=1:10
      Y(indice, 1)=data{indice}.err_te;
      N(indice, 1)=size( data{indice}.network.IW{1}, 1 );
  end

  subplot(2,1,1);
  bar(Y,'group')
  xlabel('Passi del cross validation');
  ylabel('Errore percentuale sul testing set');

  subplot(2,1,2);
  bar(N,'group')
  xlabel('Passi del cross validation');
  ylabel('Numero neuroni nascosti');

