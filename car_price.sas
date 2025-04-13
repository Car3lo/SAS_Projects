/* MP4 CAR PRICE */
LIBNAME MP1_4 "/home/u64152399/MP1_4/";

PROC IMPORT DATAFILE = "/home/u64152399/MP1_4/CAR PRICE.xlsx"
OUT = MP1_4.CAR_PRICE
DBMS = XLSX /* EXCEL for SAS PC, XLSX for SAS Studio */
REPLACE;

SHEET = "Data";
RANGE = "A:Z";

/* TASK 1*/
/*1. 4 Doors vs 2 Doors */
PROC TTEST DATA = mp1_4.car_price SIDES=U;
	CLASS doornumber;
	VAR price;
	WHERE doornumber IN ('four', 'two');
RUN;
/*
HO: Mean Price of 4 Doors = Mean Price of 2 Doors
HA: Mean Price of 4 Doors > Mean Price of 2 Doors

Reject HO if P-value < 0.05

P = 0.3838
# At 5% Significance, there is sufficient evidence to conclude that there is no difference between the average price of Cars with 4 doors to 2 Doors
*/
	
	
/* 2. Significant Difference between Mean Prices of Carbody Types */
/* ANOVA */
PROC ANOVA DATA = MP1_4.car_price;
	CLASS carbody;
	MODEL price = carbody;
	MEANS carbody / HOVTEST;
RUN;

/* 
HO: There is no significant difference between the mean prices of different Carbody Types
HA: At least one Carbody type's mean price is different from the others  

Reject HO if P-Value < 0.05

P = 0.0001

At 5% Significance, there is a significant difference between at least one of the Carbody Type mean prices
*/


/* 3. Can Fuel type alone be used to predict the expected price of a car? */
/* CHATGPT: https://chatgpt.com/share/67da6ea2-5f60-8010-9be3-12bb368337ac */
PROC GLM DATA = MP1_4.car_price;
    CLASS fueltype;
    MODEL price = fueltype;
RUN;

/* Since R^2 0.010621 or 1.06%. It indicates that Fueltype alone may not be realible to predict the expected price of a car */


/*********** TASK 2 ***********/
PROC REG DATA = MP1_4.car_price;
	MODEL price = 
	wheelbase
	/*carlength*/
	/*carwidth*/ /*autocorrelated variables*/
	/*carheight*/
	/*curbweight*/
	enginesize /*Makes sense that enginsize is autocorrelated with horsepower */
	/*boreratio*/
	stroke
	compressionratio
	/*horsepower*/
	peakrpm
	/*citympg*/
	/*highwaympg*/;
RUN;

PROC CORR DATA = MP1_4.car_price;
	VAR 	wheelbase
	/*carlength*/
	/*carwidth*/ /*autocorrelated variables*/
	/*carheight*/
	/*curbweight*/
	enginesize /*Makes sense that enginsize is autocorrelated with horsepower */
	/*boreratio*/
	stroke
	compressionratio
	/*horsepower*/
	peakrpm
	/*citympg*/
	/*highwaympg*/;
RUN;

/* Final model:  PRICE = WHEELBASE + ENGINESIZE + STORKE + COMPRESSIONRATIO + PEAKRPM
/* CONDITION 1: Minimum 3 Independent Variables */
/* CONDITION 2: All Independent Variables' Coefficients are Efficient */
/* CONDITION 3: Adjusted R^2 > 75% */
/* CONDITION 4: NO VARIABLES ARE CORRELATED > 0.6 */

/* INTERPRETATION FROM CHATGPT https://chatgpt.com/share/67da6ea2-5f60-8010-9be3-12bb368337ac
Intercept: When all predictors are zero, the model estimates a car price of -$2,185,568 (though this value is not practically meaningful).
Wheelbase: For each one-unit increase in wheelbase, the car price increases by approximately $11,599, holding other factors constant.
Enginesize: Each additional unit in engine size is associated with an approximate $9,270 increase in car price, holding other factors constant.
Stroke: For every one-unit increase in stroke, the car price decreases by about $194,804, holding other factors constant.
Compression Ratio: A one-unit increase in compression ratio is associated with an increase of roughly $14,418 in car price, holding other factors constant.
Peak RPM: For each additional unit of peak RPM, the car price increases by approximately $214, holding other factors constant.

*/