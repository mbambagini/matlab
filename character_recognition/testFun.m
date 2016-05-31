function [net err] = testFun( p, t, min_max, nuerons, train_fun, error_fun, f_out, goal, epochs, p_sano, t_sano)
% This function creates and trains a neural network
%
% Input parameters:
% p, t: training set
% p_test, t_test: test set
% neurons: neuron number
% train_fun: train function
% error_fun: error function
% f_out: each epochs/f_out the function shows data
% goal: performance goal
% epochs: max epoch number
%
% Output parameter:
% output: neural networks made 

  %default arguments
  if nargin<6
      disp('Other parameters are necessary')
      return
  end
  if nargin<7
      f_out=1;
  end
  if nargin<8
      goal=0.001;
  end
  if nargin<9
      epochs=20000;
  end

  %Neural network information
  disp([10, 'Neuroni strato nascosto: ', num2str(nuerons)])
  disp(['Algoritmo di addestramento: ', train_fun])
  disp(['Funzione di errore: ', error_fun])

  %it creates the network
  net=newff(min_max, [nuerons 26], {'logsig', 'logsig'}, train_fun, 'learngdm', error_fun);

  %it sets the parameters
  net.trainParam.show=round(epochs/f_out);
  net.trainParam.epochs=epochs;
  net.trainParam.goal=goal;
  net.trainParam.min_grad=1e-25;

  %it trains the network
  net = train(net, p, t);
%  if p_sano~=0
      ' entrato '
      net = train(net, p_sano, t_sano);
 % end

