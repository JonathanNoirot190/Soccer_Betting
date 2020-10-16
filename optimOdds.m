function [oddsm, oddsM, C, sigma] = optimOdds(X, y)
  
  % Set Options
  options = optimset('GradObj', 'on', 'MaxIter', 400);
  g = 0;
  th = 0;
  v = 100;
  oddsm = 0;
  oddsM = 0;
  C = 0;
  sigma = 0;
  
  % Optimize
  for odm = 1.1:0.1:1.4
    for odM = 1.8:0.1:2.3
    
      W = [X, y];
      W = W(min(W(:, 1:3)') <= odM & min(W(:, 1:3)') >= odm, :);
      n1 = round(0.8*length(W(:, 1)));
      
      W_train = W(1: n1, :);
      X_train = W_train(:, 1:2);
      y_train = W_train(:, 4);
      initial_theta = zeros(size(polynomial(X_train), 2), 1);
      
      W_test = W(n1: end, :);
      X_test = W_test(:, 1:2);
      y_test = W_test(:, 4);
      
      [C1, sigma1] = dataset3Params(X_train, y_train, X_test, y_test);
      model = svmTrain(X_train, y_train, C, @(x1, x2) gaussianKernel(x1, x2, sigma)); 
%      [theta, J, exit_flag] = fminunc(@(t)(costFunction(t, X_train, y_train)), initial_theta, options);
      
      
      X_test = W_test(:, 1:3);
      G = gain(model, X_test, y_test, v, 1, odm, odM);
      if G > g
        g = G
        oddsM = odM;
        oddsm = odm;
        C = C1;
        sigma = sigma1;
      end
    end
  end
  g
end

