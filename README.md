# kquantlib

A kdb library to call Quantlib C++ library via embedpy with a simple interface (similar to R Quantlib interface)

## Example

### Price an European Option

```kdb
q).ql.EuropeanOption[`call; 100; 120; 0.0; 0.0; 1f; 0.2; ()!()]
NPV  | 2.107961
delta| 0.2065062
gamma| 0.01436687
vega | 28.34013
theta| -2.873374
rho  | 18.28865
```

### implied vol from option prices

```kdb
q).ql.EuropeanOptionImpliedVolatility[`call; 2.107961; 100; 120; 0.0; 0.0; 1f; .25]
0.2
```
