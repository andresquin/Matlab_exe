% Exemple 7
% ANALYSE DE SHARPE AVEC 4 FACTEURS DE STYLES

% matlab return based style analysis

% Download des donn�es (prix)
load Data_AnalyseStyle.mat

% Les donn�es sont en prix. On prend log(x(t)/x(t-1)),ce qui �quivaut �
% prendre le logarithm des rendements.
logFonds = Rendement_Ptf;
logFacteursStyles = (Rendement_Styles);
NbFacteurs = size(logFacteursStyles,2); %Nbre de facteurs

% Calcul des corr�lations entre les facteurs de styles
Matcor = corrcoef(logFacteursStyles)

% Analyse de styles (Sharpe)
% On effectue une r�gression lin�aire avec contraintes que les b�tas soient
% positifs et que leur somme = 1.
% On utilise la fonction lsqlin, qui r�sout les probl�mes de minimisation
% des moindres carr�s avec contraintes

%**************************************
% (Toute la p�riode 2003-2006)
% Fonds VIT 
y1 = logFonds(:,1);
% x = lsqlin(C,d,A,b,Aeq,beq,lb,ub)
% x = lsqlin(Problem) o� Problem est une structure ayant les champs
% ci-dessous
Problem.C = -logFacteursStyles;
Problem.d = -y1;
Problem.A = [];     % Aucune contrainte d'in�galit�
Problem.b = [];     % Aucune contrainte d'in�galit�
Problem.Aeq = ones(1,NbFacteurs);
Problem.beq = 1;
Problem.lb = zeros(NbFacteurs,1);
Problem.ub = [];
Problem.x0 = [];
options = optimset('LargeScale', 'off');
Problem.options = options;
Problem.solver = 'lsqlin';
% On r�sout maintenant le probl�me:
betaVIT = lsqlin(Problem)

% Fonds FAA (Toute la p�riode)
%y2 = logFonds(:,1);
% La d�finition du probl�me est la m�me, sauf pour le vecteur d
%Problem.d = -y2;
%betaFAA = lsqlin(Problem)

% Fonds FID (Toute la p�riode)
%y3 = logFonds(:,1);
% La d�finition du probl�me est la m�me, sauf pour le vecteur d
%Problem.d = -y3;
%betaFID = lsqlin(Problem)

% Organisation des r�sultats
ResultsAll = [ betaVIT']
%ResultsAll = [cell(1,1), num2cell(ResultsAll)]

%*******************************************
% FEN�TRE MOBILE (ROLLING WINDOW)
% Pour effectuer l'analyse de Sharpe avec une fen�tre mobile de 100 jours,
% nous allons stocker nos r�sultats dans la matrice ResultsRolling o�
% chaque colonne repr�sentera une nouvelle p�riode. On aura donc une
% matrice de NbFacteurs x (Nombre de p�riodes).

% Fonds VIT
Fenetre = 60;
NombrePeriodes = length(Dates) - Fenetre;
ResultsRollingVIT = ones(NbFacteurs, NombrePeriodes)*NaN;
for i = 1:NombrePeriodes
    %On d�finit le probl�me en s�lectionnant les bonnes donn�es
    yTemp = logFonds(i:i+Fenetre-1, 1);
    FacteursTemp = logFacteursStyles(i:i+Fenetre-1, :);

    % La d�finition du probl�me est la m�me, sauf pour le vecteur d et la
    % matrice C qui a maintenant moins de lignes
    Problem.C = -FacteursTemp;
    Problem.d = -yTemp;
    betaTemp = lsqlin(Problem);
    
    % On stocke l'information dans le vecteur ResultsRolling
    ResultsRolling4(:, i) = betaTemp;
end;

close all

plot(bar( ResultsRolling4(10,:),'stacked'));
%xlabel('Volatility');ylabel('Asset weights');
%title('Asset allocations');
%legend('Asset1','Asset2','Asset3','Asset4');
%axis([0.15 .5 0 1])



%subplot(2,1,1); plot(Frontier(:,1),Frontier(:,2),'-');
%xlabel('Volatility');ylabel('Expexted return');
%title('Optimal Portfolios');
%axis([0.15 .5 E_r_min max(E_r)])
%subplot(2,1,2);bar(Frontier(:,1),X_mtx','stacked');
%xlabel('Volatility');ylabel('Asset weights');
%title('Asset allocations');
%legend('Asset1','Asset2','Asset3','Asset4');
%axis([0.15 .5 0 1])
