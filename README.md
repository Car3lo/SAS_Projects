# SAS Projects
![SAS](https://img.shields.io/badge/SAS-blue)

## Flagging Barcodes
- TPV.xlsx and EDC.txt are datasets that have patients with barcode numbers encoded during their visits.
- The goal is to compare both datasets and see where the barcodes do not match (order of barcode does not matter)
- The difficult part is how different the two dataests are structured which required a lot of data manipulation
- `SAS` `Data Cleaning`
- Codes are in `barcode_mistmatch.sas`
**Before Cleaning**
  
**TPV**
![Before TPV](https://lh3.googleusercontent.com/pw/AP1GczNhIiMVMZPgxzsCgDywWZ01q29qxv4Vdo4u0PkLQk5ZJhIjt9OjYFm37R6Pp_Emv9wONbTxEuBJHN-eHgMEyHO6c5fuo3hKVCyFCCtC_BoFH0IkEEKzx7AFYQjlVqaChRMNiI3nCT9gxFKaypGc5Ivg=w1168-h806-s-no-gm?authuser=0)

**EDC**
![Before EDC](https://lh3.googleusercontent.com/pw/AP1GczPs-Ke4Rc6RixmkrGPaw5La1bJEtebKjnfK2MW8V5DL0ZpWg6MoxhNTEH_VTJteM8RKpfK_HARoaKDfKHM7zyzIq_e4KTPwk4i0XyxCEBNE_jM9eU2zYgT88iIZDshqHHcBINnjbDPJzHK5ycH8xKi5=w428-h750-s-no-gm?authuser=0)

**After Cleaning**
![After](https://lh3.googleusercontent.com/pw/AP1GczPgwwU3UQ8YmDSBXq_kSz3kYjR2rvJokAs56iuSBVXXMsHBHiRwpHsbENETVxrkb8vL-S9b9DRKh_FFF5feRkeZSvBxQ_c7GIdBBWvvYTb90wxKGR9j7M7P-AV3q-L9JkDMQKfD5S2syfkRdMFkVPvv=w1169-h815-s-no-gm?authuser=0)
