rates = read.table('收益率.csv', header=T, sep=',')

library('forecast')
SSEC = auto.arima(rates$SSEC, trace=T)
SCI = auto.arima(rates$SCI, trace=T)
FTSE100 = auto.arima(rates$FTSE100, trace=T)
DAX30 = auto.arima(rates$DAX30, trace=T)
CAC40 = auto.arima(rates$CAC40, trace=T)

# 残差ADF检验
print(adf.test(SSEC$residuals))

# GARCH
library('fGarch')
library('tseries')
#library('rugarch')
garch = function(seq)
{
  res = na.omit(seq$residuals)
  model = garchFit(~garch(1,1), data=res, trace=F)
  return(model)
}
SSEC_GARCH = garch(SSEC)
SCI_GARCH = garch(SCI)
FTSE100_GARCH = garch(FTSE100)
CAC40_GARCH = garch(CAC40)