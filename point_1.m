
%  Télécharger les prix journaliers entre 01-01-2002 et 31-12-2011 
%  des indices de marché suivants dans un fichier

 
% 1. Importer vos données sous Matlab 
%    (chaque série de prix doit former un vecteur colonne).

[data, textdata]=xlsread('Data');
donnees = data;
% 2. Calculer les rendements journaliers de chacun des indices avec Matlab
[nlignes, ncolonnes]=size(donnees);
MatriceRendements = zeros(nlignes - 1, ncolonnes);
MatriceRendements = log(donnees(2:end,:)) - log(donnees(1:end-1,:));
xlswrite('TP_Premierpoint1.xls', MatriceRendements,'rendements','A1')

% 3.Calculer les rendements historiques moyens de chacun des indices avec Matlab.

Rent_moy_hist=mean(MatriceRendements)*100; % Percent
Rent=Rent_moy_hist(1:6);

data1=Rent;     
data_cells=num2cell(data1);     %Conver donnne a cellule

col_header={'S_P500' 'S_PTSX' 'CAC40','NIKKEI' 'BOVESPA' 'DAX'};     %label pour les marches

row_header={'Rendement'};     % lable pour le rendement

output_matrix=[{' '} col_header; row_header data_cells];     % atacher label avec matrice

xlswrite('TP_Premierpoint1.xls',output_matrix,'rend_moyenne','A1');     %ecrire donnes sur un ficher xls

% 4.Calculer les écart-types de chacun des indices avec Matlab. 

ecart_types=std(MatriceRendements);
ecart_six_marches=ecart_types(1:6);

data2=ecart_six_marches;     
data_cells=num2cell(data2);     %Conver donnne a cellule

col_header={'S_P500' 'S_PTSX' 'CAC40','NIKKEI' 'BOVESPA' 'DAX'};     %label pour les marches

row_header={'ecart-types'};     % lable pour le rendement

output_matrix=[{' '} col_header; row_header data_cells];     % atacher label avec matrice

xlswrite('TP_Premierpoint1.xls',output_matrix,'ecart-types','A1');

%5. Calculer la matrice de variance-covariance entre les rendements des indices avec Matlab

Var_Cov=cov(MatriceRendements(:,1:end-1));

xlswrite('TP_Premierpoint1.xls',Var_Cov,'Var_Cov','A1')

% 6 Calculer la matrice de corrélation entre lesrendements des indices avec Matlab

Mat_corr=corr(MatriceRendements(:,1:end-1));

data3=Mat_corr;     
data_cells=num2cell(data3);

col_header={'S_P500' 'S_PTSX' 'CAC40','NIKKEI' 'BOVESPA' 'DAX'};     %label pour les marches

row_header(1:6,1)={'S_P500' 'S_PTSX' 'CAC40','NIKKEI' 'BOVESPA' 'DAX'};     % label pour le rendement

output_matrix=[{' '} col_header; row_header data_cells];     % atacher label avec matrice

xlswrite('TP_Premierpoint1.xls',output_matrix,'Mat_corr','A1');



%9. Je vais verifier la matrice de correlation au differtens moment dans
%les temps pour montrer la correlation superior ou infeiur avant et apres
%la crisis.

%-----------------------------2002-2005-----------------------------------
[datan, textdata]=xlsread('avant_apres','2002_2005')
corr_2002_2005=corr(datan)

data4=corr_2002_2005;     
data_cells=num2cell(data4);

col_header={'S_P500' 'S_PTSX' 'CAC40','NIKKEI' 'BOVESPA' 'DAX'};     %label pour les marches

row_header(1:6,1)={'S_P500' 'S_PTSX' 'CAC40','NIKKEI' 'BOVESPA' 'DAX'};     % lable pour le rendement

output_matrix=[{' '} col_header; row_header data_cells];     % atacher label avec matrice

xlswrite('ex9.xls',output_matrix,'corr2002_2005','A1');
%--------------------------------2006-2007 -----------------------------------
[datan1, textdata]=xlsread('avant_apres','2006_2007')
corr_2006_2007=corr(datan1)

data5=corr_2006_2007;     
data_cells=num2cell(data5);

col_header={'S_P500' 'S_PTSX' 'CAC40','NIKKEI' 'BOVESPA' 'DAX'};     %label pour les marches

row_header(1:6,1)={'S_P500' 'S_PTSX' 'CAC40','NIKKEI' 'BOVESPA' 'DAX'};     % lable pour le rendement

output_matrix=[{' '} col_header; row_header data_cells];     % atacher label avec matrice

xlswrite('ex9.xls',output_matrix,'corr2006_2007','A1');
%-------------------------------2008-2009----------------------------------

[datan2, textdata]=xlsread('avant_apres','2008_2009')
corr_2008_2009=corr(datan2)

data6=corr_2008_2009;     
data_cells=num2cell(data6);

col_header={'S_P500' 'S_PTSX' 'CAC40','NIKKEI' 'BOVESPA' 'DAX'};     %label pour les marches

row_header(1:6,1)={'S_P500' 'S_PTSX' 'CAC40','NIKKEI' 'BOVESPA' 'DAX'};     % lable pour le rendement

output_matrix=[{' '} col_header; row_header data_cells];     % atacher label avec matrice

xlswrite('ex9.xls',output_matrix,'corr2008_2009','A1');

%-----------------------------2010-2011------------------------------------


[datan3, textdata]=xlsread('avant_apres','2010_2011')
corr_2010_2011=corr(datan3)

data7=corr_2010_2011;     
data_cells=num2cell(data7);

col_header={'S_P500' 'S_PTSX' 'CAC40','NIKKEI' 'BOVESPA' 'DAX'};     %label pour les marches

row_header(1:6,1)={'S_P500' 'S_PTSX' 'CAC40','NIKKEI' 'BOVESPA' 'DAX'};     % lable pour le rendement

output_matrix=[{' '} col_header; row_header data_cells];     % atacher label avec matrice

xlswrite('ex9.xls',output_matrix,'corr2010_2011','A1');



