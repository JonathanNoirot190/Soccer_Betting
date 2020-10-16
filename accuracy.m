function r = accuracy(X, y, p)
  r = 0;
  for i = 1:length(p)
      if p(i, 1) == y(i, 1)
        r++;
      end
      
  end
  r /= length(p);
end
