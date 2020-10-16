function g = gain(model, X, y, v, th, oddsm, oddsM)

  mise = v; % Mise initiale
  
  g = 0;

  n = floor(length(X(:, 1))/10); % Nombre de journée étudiées

  for i = 1:n
    
    X1 = X(10*i - 9: 10*i, :); % Journée étudiée
    y1 = y(10*i - 9: 10*i, :);
    
    bet = optimizeBet(model, X1, mise, th, oddsm, oddsM);
    g = sum(min(X1')'.*y1.*bet);
    mise = g;
    
  end
  
end
