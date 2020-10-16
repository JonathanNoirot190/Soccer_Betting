%% Ici nous utilisons les méthodes de regression logistique pour déterminer
%% suivant les cotes des matchs si le bookmaker a raison ou non
%% Ensutie nous chercherons à prédire les résultats

%% Initialization
clear ; close all; clc

load('bwin')
pkg load parallel

X = cotes;
y = cast(prediction', 'double');

%[oddsm, oddsM, C, sigma] = optimOdds(X, y)

th = 0.557;
oddsM = 2;
oddsm = 1.1;
a = 0.671;
C = 0.3;
sigma = 0.1;

W = [X, y];
W = W(min(W(:, 1:3)') <= oddsM & min(W(:, 1:3)') >= oddsm, :);
n1 = round(0.8*length(W(:, 1)));

W_train = W(1: n1, :);
X_train = W_train(:, 1:2);
y_train = W_train(:, 4);
initial_theta = zeros(size(polynomial(X_train), 2), 1);

W_test = W(n1: end, :);
X_test = W_test(:, 1:2);
y_test = W_test(:, 4);

%fprintf(['Plotting data with + indicating (y = 1) examples and o indicating (y = 0) examples.\n']);

%plotData(X(:, 1:2), y);


% Add intercept term to x and X_test
%X = mapFeature(X(:,1), X(:,2));

% Set Options
options = optimset('GradObj', 'on', 'MaxIter', 400);


%  k++;
%end
%plot(Th, A)
% Optimize
%[theta, J, exit_flag] = fminunc(@(t)(costFunction(t, X_train, y_train)), initial_theta, options);

% SVM Parameters

% We set the tolerance and max_passes lower here so that the code will run
% faster. However, in practice, you will want to run the training to
% convergence.
model= svmTrain(X_train, y_train, C, @(x1, x2) gaussianKernel(x1, x2, sigma)); 
visualizeBoundary(X_test, y_test, model);

y1 = svmPredict(model, X_test);
tp = 0;
for i = 1:length(y1)
  if y1(i, 1) == y_test(i, 1) == 1
    tp ++;
  end
end

precision = tp/sum(y1);

% Evaluate accuracy of algo with test-set


%Find the best threshold to optimize the prediction accuracy
%A = [];
%Th = [];
%k = 1;
%a = 0;
%th = 0;
%for i = 0.3:0.001:1
%  p = predict(theta, X_test, i);
%  acc = accuracy(X_test, y_test, p);
%  if acc > a
%    th = i;
%    a = acc;
%  end
%  Th(k, 1) = i;
%  A(k, 1) = acc;
%  k++;
%end
%plot(Th, A)
%
v = 17;
X = [1.91 3.5 3.7; 2.1 3.2 3.4; 3.5 3.4 2; 1.45 4 6.25; 1.07 9.5 17; ...
2.35 3.25 2.75; 1.36 4.6 6.75; 2.15 3.25 3.1; 2.25 3.1 2.8; 1.7 3.5 4];


bet = optimizeBet(model, X, v, th, oddsm, oddsM)
