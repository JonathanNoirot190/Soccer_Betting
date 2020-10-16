function p = polynomial(X)
  deg = 2;
  p = zeros(length(X), deg + 3);
  p(:, 1) = X(:, 1);
  p(:, 2) = X(:, 2);
  p(:, 3) = X(:, 1).^2;
  p(:, 4) = X(:, 2).^2;
  p(:, 5) = X(:, 1).*X(:, 2);
end
