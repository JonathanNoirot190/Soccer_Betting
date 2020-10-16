function J = cost(odds, X, y)
  % Return the benefit possibilities according to bet
  % Initialize some useful values
  n = length(odds); % number of training examples
  mise = 10;
  % You need to return the following variables correctly 
  J = zeros(size(odds), 1);
  J = 0;
  totalBet = 0;
  
  for i = 1:n
    X1 = X.*y;
    totalBet = mise*length(X(X <= odds(i, 1)));
    simpleBenefit = mise*sum(X1(X1 <= odds(i, 1)));
    J(i, 1) = (simpleBenefit - totalBet)/totalBet;
  end
end
