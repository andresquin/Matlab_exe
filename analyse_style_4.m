% Exemple 7
% ANALYSE DE SHARPE AVEC 4 FACTEURS DE STYLES

% matlab return based style analysis

% Download des données (prix)
load Data_AnalyseStyle.mat

% Les données sont en prix. On prend log(x(t)/x(t-1)),ce qui équivaut à
% prendre le logarithm des rendements.
logFonds = Rendement_Ptf;
logFacteursStyles = RendementsStyles
NbFacteurs = size(logFacteursStyles,2); %Nbre de facteurs

% Calcul des corrélations entre les facteurs de styles
Matcor = corrcoef(logFacteursStyles)

% Analyse de styles (Sharpe)
% On effectue une régression linéaire avec contraintes que les bêtas soient
% positifs et que leur somme = 1.
% On utilise la fonction lsqlin, qui résout les problèmes de minimisation
% des moindres carrés avec contraintes

%**************************************
% (Toute la période 2003-2006)
% Fonds VIT 
y1 = logFonds(:,1);
% x = lsqlin(C,d,A,b,Aeq,beq,lb,ub)
% x = lsqlin(Problem) où Problem est une structure ayant les champs
% ci-dessous
Problem.C = -logFacteursStyles;
Problem.d = -y1;
Problem.A = [];     % Aucune contrainte d'inégalité
Problem.b = [];     % Aucune contrainte d'inégalité
Problem.Aeq = ones(1,NbFacteurs);
Problem.beq = 1;
Problem.lb = zeros(NbFacteurs,1);
Problem.ub = [];
Problem.x0 = [];
options = optimset('LargeScale', 'off');
Problem.options = options;
Problem.solver = 'lsqlin';
% On résout maintenant le problème:
Styles = lsqlin(Problem)

% Organisation des résultats
ResultsAll = [ Styles']
%ResultsAll = [cell(1,1), num2cell(ResultsAll)]

%*******************************************
% FENÊTRE MOBILE (ROLLING WINDOW)
% Pour effectuer l'analyse de Sharpe avec une fenêtre mobile de 60 jours,
% nous allons stocker nos résultats dans la matrice ResultsRolling où
% chaque colonne représentera une nouvelle période. On aura donc une
% matrice de NbFacteurs x (Nombre de périodes).

% Fonds Styles
Fenetre = 60;
NombrePeriodes = length(Dates) - Fenetre;
ResultsRollingVIT = ones(NbFacteurs, NombrePeriodes)*NaN;
for i = 1:NombrePeriodes
    %On définit le problème en sélectionnant les bonnes données
    yTemp = logFonds(i:i+Fenetre-1, 1);
    FacteursTemp = logFacteursStyles(i:i+Fenetre-1, :);

    % La définition du problème est la même, sauf pour le vecteur d et la
    % matrice C qui a maintenant moins de lignes
    Problem.C = -FacteursTemp;
    Problem.d = -yTemp;
    betaTemp = lsqlin(Problem);
    
    % On stocke l'information dans le vecteur ResultsRolling
    ResultsRolling4(:, i) = betaTemp;
end;

close all


