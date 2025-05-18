# SAS Projects
![SAS](https://img.shields.io/badge/SAS-blue)

These projects primarily demonstrate `SAS Proficiency`, `Data Cleaning, Merging, and Manipulation`, `Correlation and Multiple Linear Regression Modelling`

This `README` has the description and goal of each project as well as the notable output. 

## Project 1: Flagging Barcodes from Two Datasets
- `TPV.xlsx` and `EDC.txt` are datasets that have patients with barcode numbers encoded during their visits.
- The goal is to compare both datasets and see where the barcodes do not match (order of barcode does not matter)
- The difficult part is how different the two dataests are structured which required a lot of data manipulation
- Codes are in `barcode_mistmatch.sas`
#### Before Cleaning
**TPV**
![Before TPV](https://lh3.googleusercontent.com/pw/AP1GczNhIiMVMZPgxzsCgDywWZ01q29qxv4Vdo4u0PkLQk5ZJhIjt9OjYFm37R6Pp_Emv9wONbTxEuBJHN-eHgMEyHO6c5fuo3hKVCyFCCtC_BoFH0IkEEKzx7AFYQjlVqaChRMNiI3nCT9gxFKaypGc5Ivg=w1168-h806-s-no-gm?authuser=0)

**EDC**
![Before EDC](https://lh3.googleusercontent.com/pw/AP1GczPs-Ke4Rc6RixmkrGPaw5La1bJEtebKjnfK2MW8V5DL0ZpWg6MoxhNTEH_VTJteM8RKpfK_HARoaKDfKHM7zyzIq_e4KTPwk4i0XyxCEBNE_jM9eU2zYgT88iIZDshqHHcBINnjbDPJzHK5ycH8xKi5=w428-h750-s-no-gm?authuser=0)

#### After Cleaning
![After](https://lh3.googleusercontent.com/pw/AP1GczPgwwU3UQ8YmDSBXq_kSz3kYjR2rvJokAs56iuSBVXXMsHBHiRwpHsbENETVxrkb8vL-S9b9DRKh_FFF5feRkeZSvBxQ_c7GIdBBWvvYTb90wxKGR9j7M7P-AV3q-L9JkDMQKfD5S2syfkRdMFkVPvv=w1169-h815-s-no-gm?authuser=0)


## Project 2: Regression Modelling for Car Price
- `CAR PRICE.xlsx` is the primary dataset
- Goal for the model is to have: at least 3 explanatory variables
- All explanatory variables are significant
- No multicollinearity (> 0.6)
- Adjusted R^2 > 75%
#### Correlation
![Correlation](https://lh3.googleusercontent.com/pw/AP1GczP5kwt82_D316U8_OyVy5k4yz1J5jOvO8KyQjHlwOi_PvbWRjpXcF_PRb_wZLaH2i25e7BSrXtxd_Hh1PoAc08K-1u0ETsDy6XDTvT523iXbFRhKzQf8ClI5I3ibNTiNcXeJktesqDtldke_ZhGv94c=w1183-h923-s-no-gm?authuser=0)
#### Regression
![Regression](https://lh3.googleusercontent.com/pw/AP1GczOxT4CPEKA071pMn_wf3JU5Iv5QQMn2LD-9K1v53avGgOTi7G0ujM928GkY4q5X-u9hFjGet6vwq3NpseHPht450FankP2aiuec1PTSgjeCmoHYqVtY10dDPp0hQ_e67fxcODBglbdp-6JnO_48Xv4t=w1242-h898-s-no-gm?authuser=0)
