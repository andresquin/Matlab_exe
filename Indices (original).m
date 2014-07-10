function Indices

% QUESTION 1: Importation des données
%Chargement des données
[data, textdata]=xlsread('BDO');

% QUESTION 2: Calcul des rendements journaliers moyens de chacun des indices 
[nlignes, ncolonnes]=size(data);
MatriceRendements = zeros(nlignes - 1, ncolonnes);
MatriceRendements = log(data(2:end,:)) - log(data(1:end-1,:));

S_P500 = MatriceRendements(:,1);
SP_TSX = MatriceRendements(:,2);
CAC40 = MatriceRendements(:,3);
Nikkei = MatriceRendements(:,4);
Bovespa = MatriceRendements(:,5);
DAX = MatriceRendements(:,6);

% QUESTION 3: Calcul des rendements historiques moyens de chacun des indices 
fprintf('Moyenne %f\n',mean(S_P500))
fprintf('Moyenne %f\n',mean(SP_TSX))
fprintf('Moyenne %f\n',mean(CAC40))
fprintf('Moyenne %f\n',mean(Nikkei))
fprintf('Moyenne %f\n',mean(Bovespa))
fprintf('Moyenne %f\n',mean(DAX))

% QUESTION 4: Calcul des Ecart-types de chacuns des indices

fprintf('Ecart-Types %f\n',std(S_P500))
fprintf('Ecart-Types %f\n',std(SP_TSX))
fprintf('Ecart-Types %f\n',std(CAC40))
fprintf('Ecart-Types %f\n',std(Nikkei))
fprintf('Ecart-Types %f\n',std(Bovespa))
fprintf('Ecart-Types %f\n',std(DAX))


% QUESTION 5: Calcul de la matrice variance-covariance entre les rendement
% des indices 

A=[S_P500  SP_TSX  CAC40  Nikkei  Bovespa DAX]
B=cov(A)

% QUESTION 6: Calcul de la matrice de correlation entre les rendement
% des indices 
 C=corr(A)
 
% QUESTION 7: Validons en documentation nos calculs, la relation qui lie
%la matrice de variance covariance a la matrice de correlation (equation qui
%fait intervenir les ecart-types egalemet, sous forme matricielle).

 
 
 


