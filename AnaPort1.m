%3.Analyse d’un portefeuille point c


load Data_Fonds.mat
load('Data_Facteurs.mat')

Portefeuille= sum(Rendements_Fonds,2)


[VecteursPropres,Composantes,ValeursPropres] = princomp(Rendements_Fonds)
PortionExpliquee = ValeursPropres/(sum(ValeursPropres))
CumulativePortionExpliquee = cumsum(PortionExpliquee)

% Facteur donnes de Facteur potenciel dans le premier 1
Composant_prin=untitled

% Regressions des rendements de 12 fonds sur 4 facteurs
whichstats = {'beta', 'covb', 'yhat', 'rsquare', 'adjrsquare', 'tstat', 'fstat'};
stats_1 = regstats(Portefeuille, Composant_prin,'linear',whichstats)

Results = [stats_1.tstat.beta, stats_1.tstat.t, stats_1.tstat.pval]
Coeff4Composantes = stats_1.tstat.beta
beta4comp=Coeff4Composantes(2:end)'
%Beta4Composantes = Coeff4Composantes(2:end)'*VecteursPropres_prin'


%xlswrite('TP_3point3.xls',Results,'Beta','A1')

a=cov(Composant_prin)
%CALCUL DES RISQUES TOTAL, SYSTEMATIQUE ET SPECIFIQUE
% MOD?LE ORIGINAL (AVEC MULTICOLLIN?ARIT?) (4 composantes)
RisqueTotal1 = std(Portefeuille)*sqrt(250)
RisqueSystematique1 = sqrt(250*beta4comp*cov(beta4comp)*beta4comp')
Residus1 = Portefeuille - stats_1.yhat
RisqueSpecifique1 = std(Residus1)*sqrt(250)