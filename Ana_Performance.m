%Analyse de la performance et des caractéristiques des fonds(30 points)
% Trouver les composant principal 

load Data_Fonds.mat



% utilise la matrice de covariance des donn?es X
[VecteursPropres,Composantes,ValeursPropres] = princomp(Rendements_Fonds)
PortionExpliquee = ValeursPropres/(sum(ValeursPropres))
CumulativePortionExpliquee = cumsum(PortionExpliquee)

Composant_prin=Composantes(:,1:4)

% Regressions des rendements de 12 fonds sur 4 facteurs
whichstats = {'beta', 'covb', 'yhat', 'rsquare', 'adjrsquare', 'tstat', 'fstat'};
stats_1 = regstats(Rendements_Fonds(:,1), Composant_prin,'linear',whichstats)
stats_2 = regstats(Rendements_Fonds(:,2), Composant_prin,'linear',whichstats)
stats_3 = regstats(Rendements_Fonds(:,3), Composant_prin,'linear',whichstats)
stats_4 = regstats(Rendements_Fonds(:,4), Composant_prin,'linear',whichstats)
stats_5 = regstats(Rendements_Fonds(:,5), Composant_prin,'linear',whichstats)
stats_6 = regstats(Rendements_Fonds(:,6), Composant_prin,'linear',whichstats)
stats_7 = regstats(Rendements_Fonds(:,7), Composant_prin,'linear',whichstats)
stats_8 = regstats(Rendements_Fonds(:,8), Composant_prin,'linear',whichstats)
stats_9 = regstats(Rendements_Fonds(:,9), Composant_prin,'linear',whichstats)
stats_10 = regstats(Rendements_Fonds(:,10), Composant_prin,'linear',whichstats)
stats_11 = regstats(Rendements_Fonds(:,11), Composant_prin,'linear',whichstats)
stats_12 = regstats(Rendements_Fonds(:,12), Composant_prin,'linear',whichstats)


Results = ones(7,36)*NaN;
Results(1:5,1:3) = [stats_1.tstat.beta, stats_1.tstat.t, stats_1.tstat.pval]
Results(1:5,4:6) = [stats_2.tstat.beta, stats_2.tstat.t, stats_2.tstat.pval]
Results(1:5,7:9) = [stats_3.tstat.beta, stats_3.tstat.t, stats_3.tstat.pval]
Results(1:5,10:12) = [stats_4.tstat.beta, stats_4.tstat.t, stats_4.tstat.pval]
Results(1:5,13:15) = [stats_5.tstat.beta, stats_5.tstat.t, stats_5.tstat.pval]
Results(1:5,16:18) = [stats_6.tstat.beta, stats_6.tstat.t, stats_6.tstat.pval]
Results(1:5,19:21) = [stats_7.tstat.beta, stats_7.tstat.t, stats_7.tstat.pval]
Results(1:5,22:24) = [stats_8.tstat.beta, stats_8.tstat.t, stats_8.tstat.pval]
Results(1:5,25:27) = [stats_9.tstat.beta, stats_9.tstat.t, stats_9.tstat.pval]
Results(1:5,28:30) = [stats_10.tstat.beta, stats_10.tstat.t, stats_10.tstat.pval]
Results(1:5,31:33) = [stats_11.tstat.beta, stats_11.tstat.t, stats_11.tstat.pval]
Results(1:5,34:36) = [stats_12.tstat.beta, stats_12.tstat.t, stats_12.tstat.pval]
Results(6,(1:3:end)) = [stats_1.rsquare, stats_2.rsquare,stats_3.rsquare,stats_4.rsquare,...
                     stats_5.rsquare,stats_6.rsquare,stats_7.rsquare,...
                     stats_8.rsquare,stats_9.rsquare,stats_10.rsquare,stats_11.rsquare,...
                     stats_12.rsquare]

Results(7,(1:3:end)) = [stats_1.adjrsquare, stats_2.adjrsquare,stats_3.adjrsquare,stats_4.adjrsquare,...
                     stats_5.adjrsquare,stats_6.adjrsquare,stats_7.adjrsquare,...
                     stats_8.adjrsquare,stats_9.adjrsquare,stats_10.adjrsquare,stats_11.adjrsquare,...
                     stats_12.adjrsquare]
title = {'Alpha';'Com1';'Com2';'Com3';'Com4';'r';'adjr'};
t1 = {'Beta', 't-stat', 'pval'}
title2 = repmat(t1, 1,12)
Results = [title, num2cell(Results)];
Results = [[cell(1,1), title2];Results]

xlswrite('TP_3point2.xls',Results,'Results','A1')

