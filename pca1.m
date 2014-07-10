


load Data_Fonds.mat

figure;
plot((Dates_Fonds), Rendements_Fonds);
axis tight;
datetick('x', 12);
title('Les rendements du 12 fonds');


%Matrice de covariance des données
Covar = cov(Rendements_Fonds)
 
% Matrice de correlation
Corre=  corrcoef(Rendements_Fonds)

surf(Corre)
view(2)
colorbar
title('Matrice de corrélation des rendements des 12 fonds');



% utilise la matrice de covariance des donn?es X
[VecteursPropres,Composantes,ValeursPropres] = princomp(zscore(Rendements_Fonds))
PortionExpliquee = ValeursPropres/(sum(ValeursPropres))
CumulativePortionExpliquee = cumsum(PortionExpliquee)
 


%break 
% VISUALISATION DES VECTEURS PROPRES
figure; plot(VecteursPropres(:,1:4));
legend('w1', 'w2', 'w3','w4');

figure;
bar(ValeursPropres(1:4));  %4 premieres valeurs propres
hold on;plot(cumsum(ValeursPropres(1:4)), 'r');
xlabel('no de valeurs propres');
ylabel('Valeurs propres');


