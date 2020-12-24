\l p.q

ql: .p.import`QuantLib;

.ql.EuropeanOption : {[option_type; spot_price; strike_price; dividend_rate; risk_free_rate; maturiy; volatility; opts] 
 today         : .z.D;
 maturity_date : .z.D + maturiy * 360;
 maturity_date : ql[`:Date][`dd$maturity_date; `mm$maturity_date; `year$maturity_date]; 
 option_type   : $[option_type = `call; ql[`:Option][`:Call]; option_type = `put; ql[`:Option][`:Put]; 'unsported_type];
 day_count     : ql[`:Actual365Fixed][];
 calendar      : ql[`:UnitedStates][];
 calculation_date : ql[`:Date][`dd$today;`mm$today;`year$today] ;
 payoff           : ql[`:PlainVanillaPayoff][option_type; strike_price];
 exercise         : ql[`:EuropeanExercise][maturity_date];
 european_option  : ql[`:VanillaOption][payoff; exercise];
 spot_handle   : ql[`:QuoteHandle] ql[`:SimpleQuote] spot_price;
 flat_ts       : ql[`:YieldTermStructureHandle][ql[`:FlatForward][calculation_date; risk_free_rate; day_count]];
 dividend_yield: ql[`:YieldTermStructureHandle][ql[`:FlatForward][calculation_date; dividend_rate; day_count]];
 flat_vol_ts   : ql[`:BlackVolTermStructureHandle][ql[`:BlackConstantVol][calculation_date; calendar; volatility; day_count]];
 bsm_process: ql[`:BlackScholesMertonProcess][spot_handle;  dividend_yield;    flat_ts;  flat_vol_ts];
 european_option[`:setPricingEngine] ql[`:AnalyticEuropeanEngine][bsm_process];
 res:`NPV`delta`gamma`vega`theta`rho;
 res: res!{x[y][]`}[european_option] each hsym each res;
 :res   
 }



/
.ql.EuropeanOption[`call; 100; 120; 0.0; 0.0; 1f; 0.2; ()!()]


