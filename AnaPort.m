clear all, clc
% ANALYSE EN COMPOSANTES PRINCIPALES DE L'INDICE DOW JONES (12 TITRES)

% Download des donn?es (rendements). Les donn?es sont d?j? en rendements.
load('Data_Fonds.mat')

%*******************************
% Visualisation des donn?es

figure;
plot(Rendements_Fonds);
% Calcul des corr?lations entre les facteurs de styles
figure;
Matcor = corrcoef(Rendements_Fonds)
surf(Matcor);
view(2);
colorbar;
title('Corr?lation entre les titres du Fond12');

% Calcul des volatilit?s des 12 titres
vol = std(Rendements_Fonds)*sqrt(250)
bar(vol);
title('Volatilite des Fond12');
ylabel('Volatilite');
xlabel('Titres');

%*****************************************
% Analyse en composantes principales

% 1) PRINCOMP
% Directement avec les donn?es X
% [COEFF,SCORE,latent,tsquare] = princomp(X)
% Par d?faut, utilise la matrice de covariance des donn?es X. Si on veut
% utiliser les donn?es standardis?es (bas?e sur la matrice de corr?lation),
% on doit utiliser princomp(zscore(X)).
% Note: La fonction centre les donn?es avant d'effectuer l'analyse
[VecteursPropres,Composantes,ValeursPropres] = princomp((Rendements_Fonds))
PortionExpliquee = ValeursPropres/(sum(ValeursPropres));
CumulativePortionExpliquee = cumsum(PortionExpliquee);

figure;
subplot(1,2,1);
bar(ValeursPropres);
xlabel('Lambda');
ylabel('Valeurs Propres');
title('Valeurs propres Fond12')
subplot(1,2,2);
plot(CumulativePortionExpliquee,'-*');
xlabel('Lambda');
ylabel('% cumulatif explique');
title('Portion cumulative de la variance expliquee');

figure;
plot(VecteursPropres(:,1));
hold on;
bar(VecteursPropres(:,1));
xlabel('Indice du Fond12');
ylabel('Coordonn?es du 1er Vecteur Propre');
title('Representation du premier vecteur propre Fond12');

%************************************
% R?gresions sur les composantes
% 1) R?gression sur les 5 premi?res composantes
whichstats = {'beta', 'covb', 'yhat', 'rsquare', 'adjrsquare', 'tstat', 'fstat'};
% Puisque les fonctions regstats et regress peuvent avoir seulement un
% vecteur y comme input, on fait une boucle for pour effectuer les 12
% r?gressions. On stocke les coefficients (beta), les t-stat et le R
% correspondants dans les variables Coeff5Composantes et Tstat5Composantes
% et R5Composantes.

% Initialisation des vecteurs
Coeff5Composantes = nan(6, 12);    %Chaque colonne repr?sente une r?gression
Tstat4Composantes = nan(6, 12);
R5Composantes = nan(1, 12);

% R?gression (boucle)sur 4 composants
for i=1:4,
    stats4Composantes_i = regstats(Rendements_Fonds(:,i), Composantes(:,1:5),'linear',whichstats);
    Coeff4Composantes(:,i) = stats4Composantes_i.tstat.beta;
    Tstat4Composantes(:,i) = stats4Composantes_i.tstat.t;
    R4Composantes(:,i) = sqrt(stats4Composantes_i.adjrsquare);
end;

% 1) R?gression sur les 9 premi?res composantes
whichstats = {'beta', 'covb', 'yhat', 'rsquare', 'adjrsquare', 'tstat', 'fstat'};
% Puisque les fonctions regstats et regress peuvent avoir seulement un
% vecteur y comme input, on fait une boucle for pour effectuer les 12
% r?gressions. On stocke les coefficients (beta), les t-stat et le R
% correspondants dans les variables Coeff9Composantes et Tstat9Composantes
% et R9Composantes.

% Initialisation des vecteurs

%******************************************************
%******************************************************
% D?COMPOSITION DU RISQUE ET CALCUL DES BETAS NETS

% Calcul des beta ? partir des composantes principales
% CALCUL AVEC 5 COMPOSANTES

% i) PORTEFEUILLE ?QUIPOND?R?
% Les poids sont ?gaux pour chacun des 12 titres)
w1 = ones(12,1)*(1/12);
% Calcul de la s?rie de rendement du portefeuille ?quipond?r?
Ptf1 = Rendements_Fonds*w1;
% R?gression sur les 5 premi?res composantes
stats5ComposantesPtf1 = regstats(Ptf1, Composantes(:,1:5),'linear',whichstats);
Beta5ComposantesPtf1 = stats5ComposantesPtf1.tstat.beta;

%CALCUL DES RISQUES TOTAL, SYSTEMATIQUE ET SPECIFIQUE
RisqueTotal1 = std(Ptf1)*sqrt(250);
% Alternativement, on peut calculer le risque total en utilisant
% w1'covFond12*w1
RisqueTotal1_v2 = sqrt(250*w1'*cov(Rendements_Fonds)*w1)
% Le risque syst?matique quand on utilise seulement les cinq composantes
% On calcule la matrice de covariance des 5 composantes utilis?es
cov5 = cov(Composantes(:,1:5));
RisqueSystematique1 = sqrt(250*Beta5ComposantesPtf1(2:end)'*cov5*Beta5ComposantesPtf1(2:end))
Residus1 = Ptf1 - stats5ComposantesPtf1.yhat;
RisqueSpecifique1 = std(Residus1)*sqrt(250)

% V?rification:
test1 = RisqueTotal1 - sqrt(RisqueSpecifique1^2 + RisqueSystematique1^2)


