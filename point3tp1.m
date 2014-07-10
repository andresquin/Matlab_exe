%Point 3.
%  Je telecharge directement au exercice 1 
%[data, dateNums, raw]=xlsread('TP_Premierpoint1.xls','rendements');
[data, textdata]=xlsread('Data');

%Calcul  des rendements
[nlignes, ncolonnes]=size(data);
MatriceRendements = zeros(nlignes - 1, ncolonnes);
MatriceRendements = log(data(2:end,:)) - log(data(1:end-1,:))

%%Actif = MatriceRendements(:,1);
SP500 = MatriceRendements(:,1);
SPTSX = MatriceRendements(:,2);
CAC40 = MatriceRendements(:,3);
Nikkei = MatriceRendements(:,4);
Bovespa = MatriceRendements(:,5);
DAX = MatriceRendements(:,6);

%%Actif_lag = lagmatrix(Actif,1);

SP500_lag=lagmatrix(SP500,1);
SPTSX_lag = lagmatrix(SPTSX,2);
CAC40_lag = lagmatrix(CAC40,3);
Nikkei_lag = lagmatrix(Nikkei,4);
Bovespa_lag = lagmatrix(Bovespa,5);
DAX_lag = lagmatrix(DAX,6);



%Estimation du CAPM par MCO

B = regstats(SP500,SP500_lag,'linear')

%Affichage des r?sultats
SP500_R_2 = B.rsquare     %le coefficient de d?terminantion (appel?: "R-carr?")
SP500_t = B.tstat         %les statistiques de student
SP500_Beta = SP500_t.beta       %les coefficients estim?s de la regression
SP500_SE = SP500_t.se           %les erreurs standardis?es ("standard errors")
SP500_Pval = SP500_t.pval       %les valeurs de probabilit? (appel?e "p-values")
%break


B1 = regstats(SPTSX,SPTSX_lag,'linear');

%Affichage des r?sultats
SPTSX_R_2 = B1.rsquare     %le coefficient de d?terminantion (appel?: "R-carr?")
SPTSX_t = B1.tstat         %les statistiques de student
SPTSX_Beta = SPTSX_t.beta       %les coefficients estim?s de la regression
SPTSX_SE = SPTSX_t.se           %les erreurs standardis?es ("standard errors")
SPTSX_Pval = SPTSX_t.pval       %les valeurs de probabilit? (appel?e "p-values")


B2 = regstats(CAC40,CAC40_lag,'linear');

%Affichage des r?sultats
CAC40_R_2 = B2.rsquare     %le coefficient de d?terminantion (appel?: "R-carr?")
CAC40_t = B2.tstat         %les statistiques de student
CAC40_Beta = CAC40_t.beta       %les coefficients estim?s de la regression
CAC40_SE = CAC40_t.se           %les erreurs standardis?es ("standard errors")
CAC40_Pval = CAC40_t.pval       %les valeurs de probabilit? (appel?e "p-values")


B3 = regstats(Nikkei,Nikkei_lag,'linear');

%Affichage des r?sultats
Nikkei_R_2 = B3.rsquare     %le coefficient de d?terminantion (appel?: "R-carr?")
Nikkei_t = B3.tstat         %les statistiques de student
Nikkei_Beta = Nikkei_t.beta       %les coefficients estim?s de la regression
Nikkei_SE = Nikkei_t.se           %les erreurs standardis?es ("standard errors")
Nikkei_Pval = Nikkei_t.pval       %les valeurs de probabilit? (appel?e "p-values")

B4 = regstats(Bovespa,Bovespa_lag,'linear');

%Affichage des r?sultats
Bovespa_R_2 = B4.rsquare     %le coefficient de d?terminantion (appel?: "R-carr?")
Bovespa_t = B4.tstat         %les statistiques de student
Bovespa_Beta = Bovespa_t.beta       %les coefficients estim?s de la regression
Bovespa_SE = Bovespa_t.se           %les erreurs standardis?es ("standard errors")
Bovespa_Pval = Bovespa_t.pval       %les valeurs de probabilit? (appel?e "p-values")



B5 = regstats(DAX,DAX_lag,'linear');

%Affichage des r?sultats
DAX_R_2 = B5.rsquare     %le coefficient de d?terminantion (appel?: "R-carr?")
DAX_t = B5.tstat         %les statistiques de student
DAX_Beta = DAX_t.beta       %les coefficients estim?s de la regression
DAX_SE = DAX_t.se           %les erreurs standardis?es ("standard errors")
DAX_Pval = DAX_t.pval       %les valeurs de probabilit? (appel?e "p-values")

%2.Tester la présence d'un effet ARCH.

[H,pValue,Stat,CriticalValue] = archtest( SP500-mean(SP500),[10 15 20]',0.05);
SP500_ARCH = [H pValue Stat CriticalValue]

[H,pValue,Stat,CriticalValue] = archtest( SPTSX-mean(SPTSX),[10 15 20]',0.05);
SPTSX_ARCH = [H pValue Stat CriticalValue]

[H,pValue,Stat,CriticalValue] = archtest( CAC40-mean(CAC40),[10 15 20]',0.05);
CAC40_ARCH = [H pValue Stat CriticalValue]


[H,pValue,Stat,CriticalValue] = archtest( Nikkei-mean(Nikkei),[10 15 20]',0.05);
Nikkei_ARCH = [H pValue Stat CriticalValue]

[H,pValue,Stat,CriticalValue] = archtest( Bovespa-mean(Bovespa),[10 15 20]',0.05);
Bovespa_ARCH = [H pValue Stat CriticalValue]

[H,pValue,Stat,CriticalValue] = archtest( DAX-mean(DAX),[10 15 20]',0.05);
DAX_ARCH = [H pValue Stat CriticalValue]



ARCH= [SP500_ARCH 
       SPTSX_ARCH
       CAC40_ARCH
       Nikkei_ARCH
       Bovespa_ARCH
       DAX_ARCH]
   

 %3.GARCH(1,1)
 
 %Visualisation des prix et des rendements
figure
subplot(2,1,1);plot(data);title('Evolution du prix');
subplot(2,1,2);plot(SP500);title('Evolution des rendements');
figure
subplot(2,1,1);autocorr(SP500);title('Autocorr?lation des rendements');
subplot(2,1,2);autocorr(SP500.^2);title('Autocorr?lation des rendements au carr?');
%Analyse pr?-estimation: Test ARCH pour la pr?sence d'effets ARCH
[H,pValue,Stat,CriticalValue] = archtest(SP500-mean(SP500),[10 15 20]',0.05);
Outputarch = [H pValue Stat CriticalValue]
%Estimation du mod?le GARCH(1,1)
[coeff,errors,LLF,innovations,sigmas,summary] = garchfit(SP500);
garchdisp(coeff,errors);
%Analyse post-estimation: 
%1- Analyse des termes d'erreurs standardis?es
figure
subplot(2,1,1);plot(innovations./sigmas);title('Erreurs standardis?es');
%2- Analyse des autocorr?lation des erreurs standardis?es
subplot(2,1,2);autocorr((innovations./sigmas).^2);title('Autocorr?lation des erreurs standardis?es au carr?')
%3- Visualisation de la qualit? de la sp?cification GARCH(1,1)
garchplot(innovations,sigmas,SP500);



 %Visualisation des prix et des rendements S&P TSX
figure
subplot(2,1,1);plot(data);title('Evolution du prix');
subplot(2,1,2);plot(SPTSX);title('Evolution des rendements');
figure
subplot(2,1,1);autocorr(SPTSX);title('Autocorr?lation des rendements');
subplot(2,1,2);autocorr(SPTSX.^2);title('Autocorr?lation des rendements au carr?');
%Analyse pr?-estimation: Test ARCH pour la pr?sence d'effets ARCH
[H,pValue,Stat,CriticalValue] = archtest(SPTSX-mean(SPTSX),[10 15 20]',0.05);
Outputarch = [H pValue Stat CriticalValue]
%Estimation du mod?le GARCH(1,1)
[coeff,errors,LLF,innovations,sigmas,summary] = garchfit(SPTSX);
garchdisp(coeff,errors);
%Analyse post-estimation: 
%1- Analyse des termes d'erreurs standardis?es
figure
subplot(2,1,1);plot(innovations./sigmas);title('Erreurs standardis?es');
%2- Analyse des autocorr?lation des erreurs standardis?es
subplot(2,1,2);autocorr((innovations./sigmas).^2);title('Autocorr?lation des erreurs standardis?es au carr?')
%3- Visualisation de la qualit? de la sp?cification GARCH(1,1)
garchplot(innovations,sigmas,SPTSX);
 


 %Visualisation des prix et des rendements CAC40
figure
subplot(2,1,1);plot(data);title('Evolution du prix');
subplot(2,1,2);plot(CAC40);title('Evolution des rendements');
figure
subplot(2,1,1);autocorr(CAC40);title('Autocorr?lation des rendements');
subplot(2,1,2);autocorr(CAC40.^2);title('Autocorr?lation des rendements au carr?');
%Analyse pr?-estimation: Test ARCH pour la pr?sence d'effets ARCH
[H,pValue,Stat,CriticalValue] = archtest(CAC40-mean(CAC40),[10 15 20]',0.05);
Outputarch = [H pValue Stat CriticalValue]
%Estimation du mod?le GARCH(1,1)
[coeff,errors,LLF,innovations,sigmas,summary] = garchfit(CAC40);
garchdisp(coeff,errors);
%Analyse post-estimation: 
%1- Analyse des termes d'erreurs standardis?es
figure
subplot(2,1,1);plot(innovations./sigmas);title('Erreurs standardis?es');
%2- Analyse des autocorr?lation des erreurs standardis?es
subplot(2,1,2);autocorr((innovations./sigmas).^2);title('Autocorr?lation des erreurs standardis?es au carr?')
%3- Visualisation de la qualit? de la sp?cification GARCH(1,1)
garchplot(innovations,sigmas,CAC40);


 %Visualisation des prix et des rendements Nikkei
figure
subplot(2,1,1);plot(data);title('Evolution du prix');
subplot(2,1,2);plot(Nikkei);title('Evolution des rendements');
figure
subplot(2,1,1);autocorr(Nikkei);title('Autocorr?lation des rendements');
subplot(2,1,2);autocorr(Nikkei.^2);title('Autocorr?lation des rendements au carr?');
%Analyse pr?-estimation: Test ARCH pour la pr?sence d'effets ARCH
[H,pValue,Stat,CriticalValue] = archtest(Nikkei-mean(Nikkei),[10 15 20]',0.05);
Outputarch = [H pValue Stat CriticalValue]
%Estimation du mod?le GARCH(1,1)
[coeff,errors,LLF,innovations,sigmas,summary] = garchfit(Nikkei);
garchdisp(coeff,errors);
%Analyse post-estimation: 
%1- Analyse des termes d'erreurs standardis?es
figure
subplot(2,1,1);plot(innovations./sigmas);title('Erreurs standardis?es');
%2- Analyse des autocorr?lation des erreurs standardis?es
subplot(2,1,2);autocorr((innovations./sigmas).^2);title('Autocorr?lation des erreurs standardis?es au carr?')
%3- Visualisation de la qualit? de la sp?cification GARCH(1,1)
garchplot(innovations,sigmas,Nikkei);



 %Visualisation des prix et des rendements Bovespa
figure
subplot(2,1,1);plot(data);title('Evolution du prix');
subplot(2,1,2);plot(Bovespa);title('Evolution des rendements');
figure
subplot(2,1,1);autocorr(Bovespa);title('Autocorr?lation des rendements');
subplot(2,1,2);autocorr(Bovespa.^2);title('Autocorr?lation des rendements au carr?');
%Analyse pr?-estimation: Test ARCH pour la pr?sence d'effets ARCH
[H,pValue,Stat,CriticalValue] = archtest(Bovespa-mean(Bovespa),[10 15 20]',0.05);
Outputarch = [H pValue Stat CriticalValue]
%Estimation du mod?le GARCH(1,1)
[coeff,errors,LLF,innovations,sigmas,summary] = garchfit(Bovespa);
garchdisp(coeff,errors);
%Analyse post-estimation: 
%1- Analyse des termes d'erreurs standardis?es
figure
subplot(2,1,1);plot(innovations./sigmas);title('Erreurs standardis?es');
%2- Analyse des autocorr?lation des erreurs standardis?es
subplot(2,1,2);autocorr((innovations./sigmas).^2);title('Autocorr?lation des erreurs standardis?es au carr?')
%3- Visualisation de la qualit? de la sp?cification GARCH(1,1)
garchplot(innovations,sigmas,Bovespa);



 %Visualisation des prix et des rendements DAX
figure
subplot(2,1,1);plot(data);title('Evolution du prix');
subplot(2,1,2);plot(DAX);title('Evolution des rendements');
figure
subplot(2,1,1);autocorr(DAX);title('Autocorr?lation des rendements');
subplot(2,1,2);autocorr(DAX.^2);title('Autocorr?lation des rendements au carr?');
%Analyse pr?-estimation: Test ARCH pour la pr?sence d'effets ARCH
[H,pValue,Stat,CriticalValue] = archtest(DAX-mean(DAX),[10 15 20]',0.05);
Outputarch = [H pValue Stat CriticalValue]
%Estimation du mod?le GARCH(1,1)
[coeff,errors,LLF,innovations,sigmas,summary] = garchfit(Bovespa);
garchdisp(coeff,errors);
%Analyse post-estimation: 
%1- Analyse des termes d'erreurs standardis?es
figure
subplot(2,1,1);plot(innovations./sigmas);title('Erreurs standardis?es');
%2- Analyse des autocorr?lation des erreurs standardis?es
subplot(2,1,2);autocorr((innovations./sigmas).^2);title('Autocorr?lation des erreurs standardis?es au carr?')
%3- Visualisation de la qualit? de la sp?cification GARCH(1,1)
garchplot(innovations,sigmas,DAX);



 
 
