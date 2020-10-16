function bet = optimizeBet(model, X, v, th, oddsm, oddsM)
  % optimizeBet return the predictave benefits and the bet for each match we want
  % to bet on
  n = length(X(:, 1));
  bet = zeros(n, 1); % Contain the result of the match (1 = team 1 win, 2 for
  % team 2 and 0 for a null
  
  X1= X(:, 1:2);

  p = svmPredict(model, X1);
  
  X2 = min(X')';
%  X1 = polynomial (X1);
%  h = sigmoid(X1*theta);
  
  bet = p.*X2;
  bet(X2(:, 1) < oddsm, :) = 0;
  bet(X2(:, 1) > oddsM, :) = 0;
  % Put the total of the bet to the money to bet v
  bet = bet/sum(bet)*v;
  
  bet = round(bet);
end
