function Y=VecteurGaussien
 %Fonction qui g?n?re un vecteur gaussien des rendements de 3 titres
 %corr?l?s
 %n: dimension du vecteur
 %Lambda: Matrice de variance-covariance
 %mu: Vecteur des moyennes

[data, dateNums, raw]=xlsread('TP_Premierpoint1.xls','rendements')
% 3.Calculer les rendements historiques moyens de chacun des indices avec Matlab.



SP500=data(1:end,1);
SPTSX=data(1:end,2) ;
CAC40=data(1:end,3) ;
Nikkei=data(1:end,4) ;
Bovespa=data(1:end,5) ;
DAX= data(1:end,6);


mu=[mean(SP500); mean(SPTSX); mean(CAC40); mean(Nikkei); mean(Bovespa); mean(DAX)]

A=[ SP500 SPTSX CAC40 Nikkei Bovespa DAX]
Lambda=cov(A)


 
n=6;

Z = randn(n,1)
Y = mu + chol(Lambda)'*Z 

 end