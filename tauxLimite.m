function cote = tauxLimite(X, y, taux)
  % Retourne la cote limite afin d'avoir un taux de réussité de taux*100 %
  % en se basant sur la cote la plus faible du bookmaker

  W = [X, y];
  Max = max(W(:, 1));
  rendement = length(y (y == 1))/length(y);
  while rendement < taux
    id = find(W(:, 1) == Max);
    W(id, :) = [];
    rendement = length(W((W(:, 2) == 1)))/length(W(:, 2));
%    fprintf('Taux de réussite %f \n', rendement);
    Max = max(W(:, 1));
  end
  
  cote = Max;
end
