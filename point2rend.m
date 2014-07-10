
%1.Télécharger les donnéesjournalière du MSCI entre 01-01-2002 et 31-12-2011
%2.Avec Matlab, calculer les rendements journaliers du MSCI
function point2rend
% Je telecharge directement au exercice 1 
[data, dateNums, raw]=xlsread('TP_Premierpoint1.xls','rendements');
MSCI=data(1:end,7);

[data, textdata]=xlsread('Data');
MSCI_prix= data(1:end,7);


xlswrite('TP_point2.xls',MSCI_prix ,'Cours_MSCI','A1')
xlswrite('TP_point2.xls',MSCI ,'rend_MSCI','A1')
%----------------------------------------------------------------------
%3.Calculer les rendements historiques moyens de chacun des indices avec Matlab
%-----------------Matrice_rendement----------------------------------
[data, textdata]=xlsread('Data');
donnees = data;
[nlignes, ncolonnes]=size(donnees);
MatriceRendements = zeros(nlignes - 1, ncolonnes);
MatriceRendements = log(donnees(2:end,:)) - log(donnees(1:end-1,:));
%------------------------------------------------------------------------
Rf = 0.001;

Rendement_exceden= MatriceRendements-Rf;

data1=Rendement_exceden;     
data_cells=num2cell(data1);

col_header={'S_P500' 'S_PTSX' 'CAC40','NIKKEI' 'BOVESPA' 'DAX' 'MSCI'};     %label pour les marches

 % label pour le rendement

output_matrix=[col_header; data_cells];     % atacher label avec matrice

xlswrite('TP_point2.xls',output_matrix,'renden_exc','A1');

%4. Avec Matlab, estimez le Beta de chacun des indices nationaux 
%   (beta au sens du CAPM) sur toute la période
%Rend exc
SP_500=Rendement_exceden(1:end,1);
SP_TSX=Rendement_exceden(1:end,2);
CAC=Rendement_exceden(1:end,3);
NIKKEI=Rendement_exceden(1:end,4);
BOVESPA=Rendement_exceden(1:end,5);
DAX=Rendement_exceden(1:end,6);
MSCI=Rendement_exceden(1:end,7);

B1 = regstats(SP_500,MSCI,'linear');
B2 = regstats(SP_TSX,MSCI,'linear');
B3 = regstats(CAC,MSCI,'linear');
B4 = regstats(NIKKEI,MSCI,'linear');
B5 = regstats(BOVESPA,MSCI,'linear');
B6 = regstats(DAX,MSCI,'linear');

% Calculation des Betas et affichage des résultats
R_2 = B1.rsquare;        % S&P 500
t = B1.tstat;
Beta1 = t.beta(2)      

R_2_2 = B2.rsquare;      % S&P/TSX
t2= B2.tstat;
Beta2 = t2.beta(2)

R_2_3 = B3.rsquare;      % CAC 40
t3= B3.tstat;
Beta3 = t3.beta(2)

R_2_4 = B4.rsquare;      % Nikkei
t4= B4.tstat;
Beta4 = t4.beta(2)

R_2_5 = B5.rsquare;      % Bovespa
t5= B5.tstat;
Beta5 = t5.beta(2)

R_2_6 = B6.rsquare;      % DAX
t6= B6.tstat;
Beta6 = t6.beta(2)

Beta=[Beta1 Beta2 Beta3 Beta4 Beta5 Beta6]

xlswrite('TP_point2.xls',Beta,'Betas','A1');

%5.-------------------
% 2002-2007
SP_500=Rendement_exceden(1:1030,1);
SP_TSX=Rendement_exceden(1:1030,2);
CAC=Rendement_exceden(1:1030,3);
NIKKEI=Rendement_exceden(1:1030,4);
BOVESPA=Rendement_exceden(1:1030,5);
DAX=Rendement_exceden(1:1030,6);
MSCI=Rendement_exceden(1:1030,7);

B1 = regstats(SP_500,MSCI,'linear');
B2 = regstats(SP_TSX,MSCI,'linear');
B3 = regstats(CAC,MSCI,'linear');
B4 = regstats(NIKKEI,MSCI,'linear');
B5 = regstats(BOVESPA,MSCI,'linear');
B6 = regstats(DAX,MSCI,'linear');

% Calculation des Betas et affichage des résultats
R_2 = B1.rsquare;        % S&P 500
t = B1.tstat;
Beta1 = t.beta(2)      

R_2_2 = B2.rsquare;      % S&P/TSX
t2= B2.tstat;
Beta2 = t2.beta(2)

R_2_3 = B3.rsquare;      % CAC 40
t3= B3.tstat;
Beta3 = t3.beta(2)

R_2_4 = B4.rsquare;      % Nikkei
t4= B4.tstat;
Beta4 = t4.beta(2)

R_2_5 = B5.rsquare;      % Bovespa
t5= B5.tstat;
Beta5 = t5.beta(2)

R_2_6 = B6.rsquare;      % DAX
t6= B6.tstat;
Beta6 = t6.beta(2)

Beta=[Beta1 Beta2 Beta3 Beta4 Beta5 Beta6]

xlswrite('TP_point2.xls',Beta,'Betas2007','A1');

%%2008-2011

% 2002-2007
SP_500=Rendement_exceden(1031:end,1);
SP_TSX=Rendement_exceden(1031:end,2);
CAC=Rendement_exceden(1031:end,3);
NIKKEI=Rendement_exceden(1031:end,4);
BOVESPA=Rendement_exceden(1031:end,5);
DAX=Rendement_exceden(1031:end,6);
MSCI=Rendement_exceden(1031:end,7);

B1 = regstats(SP_500,MSCI,'linear');
B2 = regstats(SP_TSX,MSCI,'linear');
B3 = regstats(CAC,MSCI,'linear');
B4 = regstats(NIKKEI,MSCI,'linear');
B5 = regstats(BOVESPA,MSCI,'linear');
B6 = regstats(DAX,MSCI,'linear');

% Calculation des Betas et affichage des résultats
R_2 = B1.rsquare;        % S&P 500
t = B1.tstat;
Beta1 = t.beta(2)      

R_2_2 = B2.rsquare;      % S&P/TSX
t2= B2.tstat;
Beta2 = t2.beta(2)

R_2_3 = B3.rsquare;      % CAC 40
t3= B3.tstat;
Beta3 = t3.beta(2)

R_2_4 = B4.rsquare;      % Nikkei
t4= B4.tstat;
Beta4 = t4.beta(2)

R_2_5 = B5.rsquare;      % Bovespa
t5= B5.tstat;
Beta5 = t5.beta(2)

R_2_6 = B6.rsquare;      % DAX
t6= B6.tstat;
Beta6 = t6.beta(2)

Beta=[Beta1 Beta2 Beta3 Beta4 Beta5 Beta6]

xlswrite('TP_point2.xls',Beta,'Betas2011','A1');


