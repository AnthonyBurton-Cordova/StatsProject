/* Generated Code (IMPORT) */
/* Source File: AmesTrainData.csv */
/* Source Path: /home/u63075710/DS6371/Final Project */
/* Code generated on: 4/7/23, 11:03 AM */

%web_drop_table(WORK.IMPORT);


FILENAME Data1 '/home/u63075710/DS6371/Final Project/AmesTrainData.csv';

PROC IMPORT DATAFILE=Data1
	DBMS=CSV
	OUT=WORK.Data1;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.Data1; RUN;


%web_open_table(WORK.Data1);

*Change catagorical variables to numeric;
data Data1;
    set _Character_;
    numeric_day = input(_Character_, comma9.);
run;

*We can view the data, but it takes a few min to load
proc print Data = Data1
run;
;

*Look at the correlation;
proc corr data = Data1;
var SalePrice LotArea YearBuilt YearRemodAdd OverallQual OverallCond;
run;

* ;
proc reg data = Data1;
model SalePrice = LotArea YearBuilt YearRemodAdd OverallQual OverallCond / stb clb VIF scorr1 scorr2;
run;

/* Variable Selection with Sig Level */
proc glmselect data = Data1;
model SalePrice = TotRmsAbvGrd Fireplaces GarageYrBlt GarageCars GarageArea WoodDeckSF OpenPorchSF EnclosedPorch ScreenPorch 
PoolArea MiscVal MoSold YrSold MSSubClass LotArea OverallQual OverallCond YearBuilt YearRemodAdd MasVnrArea BsmtFinSF1 BsmtFinSF2
BsmtUnfSF TotalBsmtSF LowQualFinSF GrLivArea BsmtFullBath BsmtHalfBath FullBath HalfBath BedroomAbvGr KitchenAbvGr/
selection = Forward(stop = CV SLE = .2) stats = adjrsq;
run;

proc glmselect data = Data1;
model SalePrice = TotRmsAbvGrd Fireplaces GarageYrBlt GarageCars GarageArea WoodDeckSF OpenPorchSF EnclosedPorch ScreenPorch 
PoolArea MiscVal MoSold YrSold MSSubClass LotArea OverallQual OverallCond YearBuilt YearRemodAdd MasVnrArea BsmtFinSF1 BsmtFinSF2
BsmtUnfSF TotalBsmtSF LowQualFinSF GrLivArea BsmtFullBath BsmtHalfBath FullBath HalfBath BedroomAbvGr KitchenAbvGr / selection = Backward(stop  = CV SLS = .2) stats = adjrsq;
run;

proc glmselect data = Data1;
model SalePrice = TotRmsAbvGrd Fireplaces GarageYrBlt GarageCars GarageArea WoodDeckSF OpenPorchSF EnclosedPorch ScreenPorch 
PoolArea MiscVal MoSold YrSold MSSubClass LotArea OverallQual OverallCond YearBuilt YearRemodAdd MasVnrArea BsmtFinSF1 BsmtFinSF2
BsmtUnfSF TotalBsmtSF LowQualFinSF GrLivArea BsmtFullBath BsmtHalfBath FullBath HalfBath BedroomAbvGr KitchenAbvGr / selection = stepwise (stop = CV) stats = adjrsq; 
run;
