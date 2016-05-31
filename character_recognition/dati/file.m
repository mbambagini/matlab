function stru = file ( data, errorValue )

  Y=zeros(10, 2);
%  stru{2}=zeros(10, 2);
%  stru{3}=zeros(10, 2);
%  stru{4}=zeros(10, 2);

  j=0;
  i=1;
  for indice=1:10
 %     switch data{indice}.neurons
%          case 15
%              i=1;
%              j=j+1;
%          case 20
%              i=2;
%          case 25
%              i=3;
%          case 30
%              i=4;
%      end
      Y(indice, 1)=data{indice}.err_tr;
      Y(indice, 2)=data{indice}.err_te;
  end

%  neurons=[15, 20, 25, 30];
  for i=1:1%4
%      subplot(2,2,i);
      bar(Y,'group')
      title(['Disturbo ', num2str(errorValue), ' e 25 neuroni']);
      xlabel('Passi del cross validation');
      ylabel('Errore percentuale');
      h = legend('Errore training set','Errore testing set',2);
      set(h,'Interpreter','none')
%      pause;
  end
