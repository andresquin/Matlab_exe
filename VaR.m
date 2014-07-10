
function VaR

[data, dateNums, raw] = xlsread('Data');                    
% Calcul  des rendements
[nlignes, ncolonnes]=size(data);
MatriceRendements = zeros(nlignes - 1, ncolonnes);
MatriceRendements = log(data(2:end,:)) - log(data(1:end-1,:));

% Calcul des rendement de chaque des indices boursiers
SP500 = MatriceRendements(1:end,1);
TSX = MatriceRendements(1:end,2);
CAC = MatriceRendements(1:end,3);
NIK = MatriceRendements(1:end,4);
BOV = MatriceRendements(1:end,5);
DAX = MatriceRendements(1:end,6);

% Calcul des rendements historiques moyens de chacun des indices 
mu = [(mean(SP500)); mean(TSX); mean(CAC); mean(NIK); mean(BOV); mean(DAX)];

% Calcul des écarts-types de chacun des indices
sigma = [(std(SP500)); std(TSX); std(CAC); std(NIK); std(BOV); std(DAX)];

% Probabilité de perte
prob = 0.05;

% Calcul de la Valeur à Risque journalière à 95%
ValueAtRisk = portvrisk(mu, sigma, prob, 1)

%les résultats
fprintf('S&P 500: %2.5f\n', ValueAtRisk(1))
fprintf('S&P TSX: %2.5f\n', ValueAtRisk(2))
fprintf('CAC40: %2.5f\n', ValueAtRisk(3))
fprintf('Nikkei: %2.5f\n', ValueAtRisk(4))
fprintf('Bovespa: %2.5f\n', ValueAtRisk(5))
fprintf('DAX: %2.5f\n', ValueAtRisk(6))
%------------------ Var 2002-2007
SP5001 = MatriceRendements(1:1231,1);
TSX1 = MatriceRendements(1:1231,2);
CAC1 = MatriceRendements(1:1231,3);
NIK1 = MatriceRendements(1:1231,4);
BOV1 = MatriceRendements(1:1231,5);
DAX1 = MatriceRendements(1:1231,6);

% Calcul des rendements historiques moyens de chacun des indices 
mu1 = [(mean(SP5001)); mean(TSX1); mean(CAC1); mean(NIK1); mean(BOV1); mean(DAX1)];

% Calcul des écarts-types de chacun des indices
sigma1 = [(std(SP5001)); std(TSX1); std(CAC1); std(NIK1); std(BOV1); std(DAX1)];

% Probabilité de perte
prob = 0.05;

% Calcul de la Valeur à Risque journalière à 95%
ValueAtRisk1 = portvrisk(mu1, sigma1, prob, 1)

%les résultats
fprintf('S&P 500: %2.5f\n', ValueAtRisk1(1))
fprintf('S&P TSX: %2.5f\n', ValueAtRisk1(2))
fprintf('CAC40: %2.5f\n', ValueAtRisk1(3))
fprintf('Nikkei: %2.5f\n', ValueAtRisk1(4))
fprintf('Bovespa: %2.5f\n', ValueAtRisk1(5))
fprintf('DAX: %2.5f\n', ValueAtRisk1(6))

%---------------------Var 2008-2011------------------------------

SP5002 = MatriceRendements(1232:end,1);
TSX2 = MatriceRendements(1232:end,2);
CAC2 = MatriceRendements(1232:end,3);
NIK2 = MatriceRendements(1232:end,4);
BOV2 = MatriceRendements(1232:end,5);
DAX2 = MatriceRendements(1232:end,6);

% Calcul des rendements historiques moyens de chacun des indices 
mu2 = [(mean(SP5002)); mean(TSX2); mean(CAC2); mean(NIK2); mean(BOV2); mean(DAX2)];

% Calcul des écarts-types de chacun des indices
sigma2 = [(std(SP5002)); std(TSX2); std(CAC2); std(NIK2); std(BOV2); std(DAX2)];

% Probabilité de perte
prob = 0.05;

% Calcul de la Valeur à Risque journalière à 95%
ValueAtRisk2 = portvrisk(mu2, sigma2, prob, 1)

%les résultats
fprintf('S&P 500: %2.5f\n', ValueAtRisk2(1))
fprintf('S&P TSX: %2.5f\n', ValueAtRisk2(2))
fprintf('CAC40: %2.5f\n', ValueAtRisk2(3))
fprintf('Nikkei: %2.5f\n', ValueAtRisk2(4))
fprintf('Bovespa: %2.5f\n', ValueAtRisk2(5))
fprintf('DAX: %2.5f\n', ValueAtRisk2(6))



