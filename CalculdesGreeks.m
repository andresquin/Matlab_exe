function prix_note = CalculdesGreeks()
clc;
%Etape 1: importantion des donnes
%maturite
T = xlsread('Donnees_Note.xls', 'Current Data', 'D2');
%prix initiaux
Prix = xlsread('Donnees_Note.xls', 'Current Data', 'F5:F6');
%volatilites
Vols = xlsread('Donnees_Note.xls', 'Current Data', 'G5:G6');
%%dividendes
Div = xlsread('Donnees_Note.xls', 'Current Data', 'H5:H6');
%pond?rations
Weights = xlsread('Donnees_Note.xls', 'Current Data', 'I5:I6');
%taux sans risque
r = xlsread('Donnees_Note.xls', 'Current Data', 'F9');
%corr matrix
CorrMat = xlsread('Donnees_Note.xls', 'Current Data', 'F17:G18');
%G?n?ration des nombres normaux standards
nsim=1000;
randn('state',0);
N_assets = size(Vols,1);
Z = randn(nsim,N_assets);
Weights_Invested = 100*Weights./Prix;

%Etape 2: Calcul du prix de l'option
prix_note = Calcul_Prix_Option(T,Prix,Vols,Div,Weights_Invested,r,CorrMat,nsim,Z);

%?tape 3 : Calcul des grecs
%Calcul du Rho
prix_note_plus = Calcul_Prix_Option(T,Prix,Vols,Div,Weights_Invested,r+0.01,CorrMat,nsim,Z);
prix_note_moins = Calcul_Prix_Option(T,Prix,Vols,Div,Weights_Invested,r-0.01,CorrMat,nsim,Z);
Rho = (prix_note_plus - prix_note_moins)/2
%Calcul du Vega relativement au premier sous-jacent
prix_note_plus = Calcul_Prix_Option(T,Prix,Vols+[0.01;0],Div,Weights_Invested,r,CorrMat,nsim,Z);
prix_note_moins = Calcul_Prix_Option(T,Prix,Vols-[0.01;0],Div,Weights_Invested,r,CorrMat,nsim,Z);
Vega1 = (prix_note_plus - prix_note_moins)/2
%Calcul du delta relativement au premier sous-jacent
prix_note_plus = Calcul_Prix_Option(T,Prix.*[1.01;1],Vols,Div,Weights_Invested,r,CorrMat,nsim,Z);
prix_note_moins = Calcul_Prix_Option(T,Prix.*[0.99;1],Vols,Div,Weights_Invested,r,CorrMat,nsim,Z);
delta1 = (prix_note_plus - prix_note_moins)/(2*0.01*Prix(1,1))
%Theta

%Gamma

function prix_option = Calcul_Prix_Option(T,Prix,Vols,Div,Weights_Invested,r,CorrMat,nsim,Z)
%Etape 2: Calcul du prix de l'option
%facteurs de tendance
Drift = (r - Div- 0.5*(Vols.^2))*T;
%calcul de la matrice var cov
Sigma = (Vols*Vols').*CorrMat;
%nombre d'actifs
N_assets = size(Vols,1);
%Decomposition de Cholesky de la matrice var-cov (une 2x2)
C = chol(Sigma*T); 
%Simulation des rendements selon le MBG (une 1000x2)
Rendements = repmat(Drift',nsim,1) + Z*C;
%Calcul des prix simul?s (une 1000x2)
Prix_simules = repmat(Prix',nsim,1).*exp(Rendements);
Notional = 100;
%Prix initial
%Initial_Basket_Price = Weights_Invested'*Prix;
%Prix simules du basket
Simulated_Basket_Prices = Prix_simules*Weights_Invested;
%Rendements simules du basket
Rendements_simules = Simulated_Basket_Prices/Notional;
%Calcul du vecteur des paiements de l'option
Payoff = max(Notional*(Rendements_simules-1),0);
%Prix de l'option
prix_option = exp(-r*T)*mean(Payoff);