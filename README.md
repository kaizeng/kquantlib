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

### Implied vol from option prices

```kdb
q).ql.EuropeanOptionImpliedVolatility[`call; 2.107961; 100; 120; 0.0; 0.0; 1f; .25]
0.2
```

### Vol Curves

```kdb
DATE: 2020.12.31;
EXP:  2021.01.15;
spot: first exec CLOSE from .ek.getOhlc[`SPY.P; 2020.12.31; 2020.12.31;`daily]
strikes:  `int$spot + til[51] - 20

/option market prices
options: .ek.getOption[`SPY; `c; EXP; ] each strikes
opt_prices: update strike: strikes from .ek.getOhlc[options; 2020.12.31; 2020.12.31;`daily]
vols: {.ql.EuropeanOptionImpliedVolatility[`call; first x`CLOSE; spot; first x`strike; 0.0; 0.0; (EXP-DATE)%360; .1]} each  opt_prices

/plot
plt: .p.import`matplotlib.pyplot
plt[`:plot][strikes; vols; `label pykw `vol];
plt[`:vlines][spot; min vols; max vols; `label pykw `spot; `colors pykw `r];
plt[`:title] "SPY Jan 15 2021 Vol Curve";
plt[`:xlabel]`strike;
plt[`:legend][];
plt[`:show][];
```

![img]('/examples/volcurve.png')
