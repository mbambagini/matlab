function output = testSup(errorValue)
% This function tests more possibile neural networks

  %parameters
  imageFolder='./dataSet/';
  y=5;
  x=7;
  type='f'; %for newff
  %type='e'; %for newrbe
  %type='r'; %for newrb
%  neurons = [15 20 25 30];
  neurons=[25];
%  algorithms =    {'trainlm', 'trainlm', 'trainlm', 'traingda', 'traingdx'};
  algorithms =    {'traingda'};
%  error_functions={'errorFun', 'mse', 'sse', 'mse', 'mse'};
  error_functions={'mse'};
  min_max=[zeros(x*y,1), ones(x*y,1)];
  index=1;
  output=cell(10,1);
  if nargin==0
      errorValue=0;
  end
  for cv=1:10
      if cv~=1
         return
      end
      %it generates the training set and the test set
      disp([10, 'Generazione del training set e test set, con cross validation, folder=', num2str(cv)])
      %this is not very efficient, but the function executes getImageSetCv only
      %10 times, and this is a batch function
      [p, t, p_test, t_test] = getImageSetCv(imageFolder, x, y, cv, 0);
      p_sano=p;
      t_sano=t;
      if errorValue~=0
          [p_2, t_2, p_test_2, t_test_2] = getImageSetCv(imageFolder, x, y, cv, errorValue);
          p=[p p_2];
          t=[t t_2];
          p_test=[p_test p_test_2];
          t_test=[t_test t_test_2];
      end
      disp(['Numero di elementi del training set: ',num2str(size(t,2))])
      disp(['Numero di elementi del test set: ',num2str(size(t_test,2))])
      for i=1:size(algorithms, 2)
          if type~='f' && i~=1
              continue;
          end
          for z=1:size(neurons,2)
              if type~='f' && z~=1
                  continue;
              end
              %it does and trains the network
              switch type
                  case 'r'
                      net=newrb(p, t, 30, 2.3, 650, 650);
                  case 'f'
                      net=testFun(p, t, min_max, neurons(z), algorithms{i}, error_functions{i}, 1, 1e-6, 6000, p_sano, t_sano );
                  case 'e'
                      net=newrbe(p, t, 2.3);
              end
              %it computes the error
              err_test = evaluateNetwork(net, p_test, t_test);
              err_train = evaluateNetwork(net, p, t);
              %output
              if nargout~=0
                  output{index}.network=net;
                  output{index}.neurons=neurons(z);
                  output{index}.alg=algorithms{i};
                  output{index}.errf=error_functions{i};
                  output{index}.err_tr=err_train;
                  output{index}.err_te=err_test;
                  index=index+1;
              end
              disp(['Percentuale di errore sul training set: ', num2str(err_train), '%'])
              disp(['Percentuale di errore sul test set: ', num2str(err_test), '%'])
          end
      end
  end
