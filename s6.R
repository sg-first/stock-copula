df = read.table('收益率.csv', header=T, sep=',')

guiyi = function(seq) 
{ 
  seq = na.omit(seq)[1:2917]
  s = max(seq) - min(seq)
  return( (seq-min(seq))/s )
}

SSEC = guiyi(df$SSEC)
SCI = guiyi(df$SCI)
DAX30 = guiyi(df$DAX30)
CAC40 = guiyi(df$CAC40)
FTSE100 = guiyi(df$FTSE100)

library(rvinecopulib)
library(stats)
copula = function(seqA, seqB)
{
  AB = data.frame(seqA, seqB)
  obj = bicop(AB)
  print(obj)
  print(AIC(obj))
  print(BIC(obj))
  start = c(0,0)
  fitRet = fitCopula(tCopula(), as.matrix(AB), start = start)
  print(fitRet)
}

copula(SSEC, SCI)
copula(DAX30, CAC40)
copula(FTSE100, CAC40)
copula(SSEC, FTSE100)