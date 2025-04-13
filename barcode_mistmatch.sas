/* MP1_3 BARCODE MISMATCH */
/* First Upload EDC.txt and TPV.xlsx to SAS Studio */

/* TASK 1: Combine and Compare Mismatches */
LIBNAME MP1_3 "/home/u64152399/MP1_3/";

/*********** START WITH EDC.TXT FIRST ****************/
/* Import Data */
DATA MP1_3.EDC;
	INFILE "/home/u64152399/MP1_3/EDC.txt" DLM = "," FIRSTOBS = 9;
	INPUT SUBJECT$ Visit$ Barcode$; /* What if we make it all Character */
RUN;

/* Now We sort by Visit and Hopefully Barcode will be orderd */
PROC SORT DATA = MP1_3.EDC OUT = MP1_3.EDC_Sorted_Visit_Barcode;
	BY Visit Barcode;
RUN;

/* Sort by Subject */
PROC SORT DATA = MP1_3.EDC_Sorted_Visit_Barcode OUT = MP1_3.EDC_Sorted_subj;
	BY SUBJECT;
RUN;

/* Long to Wide to Prepare to CATX */
PROC TRANSPOSE DATA = MP1_3.edc_sorted_subj
			   OUT  = MP1_3.edc_sorted_wide;
		BY SUBJECT Visit;
		/*ID Barcode;*/ /*I guess that worked */
		VAR Barcode;
RUN;

/* CATX TIME */
DATA MP1_3.EDC_sorted_catx;
	SET MP1_3.EDC_sorted_wide;
	EDC_Barcode = CATX(', ', COL1, COL2, COL3, COL4);
	DROP _NAME_ COL1 COL2 COL3 COL4;
RUN;

/* Very Good, Excellent */
/* Now let us Sort by Visit and Move on to TPV */
PROC SORT DATA = MP1_3.EDC_sorted_catx OUT = MP1_3.EDC_sorted_final;
	BY Visit;
RUN;



/***********TPV NEXT.****************/
/* Most likely We separate the Barcode -> Tranpose to Long -> Sort by Visit Barcode -> Sort by Subject -> CATX -> Last Sort by Visit */
/* The whole point of doing this is to order all barcodes before making them CATX(). So that it'll truly only check for elements and not count it as False if iba yung order */
PROC IMPORT DATAFILE = "/home/u64152399/MP1_3/TPV.xlsx"
	OUT = MP1_3.TPV
	DBMS = XLSX /* EXCEL for SAS PC, XLSX for SAS Studio */
	REPLACE;
	
	SHEET = "TPV";
	RANGE = "A:D";
RUN;

/* As sir said, we will be using SCAN, CATX */
DATA MP1_3.TPV_Scanned;
	SET MP1_3.TPV;
	COL1 = SCAN(BARCODE, 1, ', ');
	COL2 = SCAN(BARCODE, 2, ', ');
	COL3 = SCAN(BARCODE, 3, ', ');
	COL4 = SCAN(BARCODE, 4, ', ');
	DROP BARCODE BP; /* No need to manually check, I trust computers with my life */
RUN;

/* Tried Tranposing while Sorted by Visit didn't like it so I'll sort by Subject*/

PROC SORT DATA = MP1_3.TPV_Scanned OUT = MP1_3.TPV_Sorted;
	BY Subject;
RUN;

/* Tranpose Now */
PROC TRANSPOSE DATA = MP1_3.TPV_Sorted
	OUT = MP1_3.TPV_Long;
	BY Subject Visit;
	VAR COL1 COL2 COL3 COL4;
RUN;

/* Sort by Visit like TPV.xlsx then double check the Excel File */
/*
PROC SORT DATA = MP1_3.TPV_Long
	OUT = MP1_3.TPV_Long_Sorted;
	BY Visit;
RUN;
LETS TRY SOMETHINGGGGGGGGGGGGG */

/* LAPIT NA, NOW I JUST SORT BY VISIT BARCODE THEN SUBJECT LIKE IN EDC */
/* DROP _NAME_ and Rename Col1 to Barcode*/
DATA MP1_3.TPV_Long_DR;
	SET MP1_3.TPV_Long; /* DR = Drop Rename */
	DROP _NAME_; 
	RENAME COL1 = Barcode;
RUN;

PROC SORT DATA = MP1_3.TPV_Long_DR OUT = MP1_3.TPV_Long_Visit_Barcode;
	BY Visit Barcode;
RUN;

/* Sort by Subject */
PROC SORT DATA = MP1_3.TPV_Long_Visit_Barcode OUT = MP1_3.TPV_Sorted_Subj;
	BY SUBJECT;
RUN;

/* Tranpose */
/* Long to Wide to Prepare to CATX */
PROC TRANSPOSE DATA = MP1_3.TPV_Sorted_Subj
			   OUT  = MP1_3.TPV_Sorted_Wide;
		BY SUBJECT Visit;
		/*ID Barcode;*/ /*LEAVE THIS */
		VAR Barcode;
RUN;

/* CATX TIME */
DATA MP1_3.TPV_Sorted_CATX;
	SET MP1_3.TPV_Sorted_Wide;
	TPV_Barcode = CATX(', ', COL1, COL2, COL3, COL4);
	DROP _NAME_ COL1 COL2 COL3 COL4;
RUN;

/* Now let us Sort by Visit and Move on to TPV */
PROC SORT DATA = MP1_3.TPV_Sorted_CATX OUT = MP1_3.TPV_Sorted_Final;
	BY Visit;
RUN;

/* HAHAHAHAHA LETS GOOOOOO */
/************ NOW WE MERGE ************/
DATA MP1_3.Combined_EDC_TPV;
	MERGE MP1_3.TPV_Sorted_Final MP1_3.EDC_Sorted_Final;
	BY Visit;
RUN;

/* HAHAHAHAHAHAHAHAH */
/* NOW TO FOR MISTAMCTH  SA WAKAS */
/* Flag */
DATA MP1_3.Combined_EDC_TPV_Flag;
	SET MP1_3.Combined_EDC_TPV;
	LENGTH Flag $20; /* Without this Barcode Mismatch will become Barco */
	IF TPV_Barcode = EDC_Barcode THEN Flag = "Match";
	ELSE Flag = "Barcode Mismatch";
	RETAIN SUBJECT Visit TPV_Barcode EDC_Barcode Flag;
RUN;



/***********************************/
/* TASK 2: TABLES */

/* Wait lang let me do a normal table with all values */
TITLE "Subjects - Match - Mismatch Table";
PROC FREQ DATA = MP1_3.Combined_EDC_TPV_Flag;
	TABLES Subject*Flag/
		NOROW
		NOCOL
		NOPERCENT;

RUN;
TITLE;

/* TASK 2 Codes */
TITLE "Number of visits with mismatching barcodes per subject.";
PROC FREQ DATA = MP1_3.Combined_EDC_TPV_Flag;
	WHERE Flag = "Barcode Mismatch";
	TABLES SUBJECT*Flag/
		NOROW
		NOCOL
		NOPERCENT;

RUN;
TITLE;

TITLE "Number of subjects with mismatching barcodes per visit.";
PROC FREQ DATA = MP1_3.Combined_EDC_TPV_Flag;
	WHERE Flag = "Barcode Mismatch";
	TABLES Visit*Flag/
		NOROW
		NOCOL
		NOPERCENT;
RUN;
TITLE;
***/
/* #1 Subjects with highest number of mismatches are 5 */

/* #2 Visits with highest number of mismatches are All 7*/



