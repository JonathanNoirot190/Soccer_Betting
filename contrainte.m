function g = contrainte(theta, lim)
  % retourne la somme des mises (theta) telle qu'elle soit
  % inférieure à lim (ex 100 euro)
  g = sum(theta) - lim;
end
