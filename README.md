# kquantlib

A kdb library to call Quantlib C++ library via embedpy with simple interface (simliar to R Quantlib interface)

e.g. to price an European Option:

```kdb
q).ql.EuropeanOption[`call; 100; 120; 0.0; 0.0; 1f; 0.2; ()!()]
NPV  | 2.107961
delta| 0.2065062
gamma| 0.01436687
vega | 28.34013
theta| -2.873374
rho  | 18.28865
```
