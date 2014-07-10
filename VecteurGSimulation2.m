function Y=VecteurGSimulation2;
 %Fonction qui g?n?re un vecteur gaussien des rendements de 3 titres
 %corr?l?s
 %n: dimension du vecteur
 %Lambda: Matrice de variance-covariance
 %mu: Vecteur des moyennes

[data, dateNums, raw]=xlsread('TP_Premierpoint1.xls','rendements');
% 3.Calculer les rendements historiques moyens de chacun des indices avec Matlab.

SP500=data(1231:end,1);
SPTSX=data(1231:end,2) ;
CAC40=data(1231:end,3) ;
Nikkei=data(1231:end,4) ;
Bovespa=data(1231:end,5) ;
DAX= data(1231:end,6);


mu=[mean(SP500); mean(SPTSX); mean(CAC40); mean(Nikkei); mean(Bovespa); mean(DAX)];

A=[ SP500 SPTSX CAC40 Nikkei Bovespa DAX];
Lambda=cov(A);

% matrice de simulation
n=6;
NombredeSim = 10000;
Y = zeros( NombredeSim,n);

    for a = 1:NombredeSim;
        Z = randn(n,1);
        Y(a,:) = (mu + chol(Lambda)'*Z );     % cho1: Écart-types des matrices
    end

Moyenne = mean(Y) 

fprintf('Moyenne de Marches: %2.5f\n',Moyenne)
end