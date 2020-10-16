function [J, nums] = costCombi(odds, X, y)
  % Return the benefit possibilities according to bet
  % Initialize some useful values
  n = length(odds);
  m = length(X(:, 1)); % number of training examples
  mise = 10;
  simpleOdd = 2.25;
  p = 10; % number of match per day
  d = m/p; % number of day match in a season
  % You need to return the following variables correctly 
  J = zeros(size(odds), 1);
  nums = zeros(size(odds), 1);
  
  
  for i = 1:n
    odd = odds(i, 1);
    totalBet = 0;
    combiBenefit = 0;
    num = 0;
    for j = 1:d
      prod = 1;
      X1 = X(10*j - 9: 10*j, 1); % Journée étudiée
      y1 = y(10*j - 9: 10*j, 1);
      
      X2 = X1;
      k = 1;
      count = 0;
      goodCombine = 1;
      while length(X2) > 0
        if prod*X1(k, 1) <= odd && X1(k, 1) <= simpleOdd
          prod *= X1(k, 1);
          goodCombine *= y1(k, 1);
          count ++;
          num ++;
        elseif count > 1
          combiBenefit += mise*prod*goodCombine;
          prod = 1;
          totalBet += mise;
          goodCombine = 1;
          count = 0;
          continue;
        end
        X2(1) = [];
        k ++;
      end
      
    end
    nums(i, 1) = num;    
    J(i, 1) = (combiBenefit - totalBet)/totalBet;
  end
end