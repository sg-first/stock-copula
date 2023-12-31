ArchTest <- function (x, lags=12, 
                      demean = FALSE) 
{
  # Capture name of x for documentation in the output  
  xName <- deparse(substitute(x))
  # 
  x <- as.vector(x)
  if(demean) x <- scale(x, center = TRUE, scale = FALSE)
  #  
  lags <- lags + 1
  mat <- stats::embed(x^2, lags)
  arch.lm <- summary(stats::lm(
    mat[, 1] ~ mat[, -1]))
  STATISTIC <- arch.lm$r.squared * 
    length(stats::resid(arch.lm))
  names(STATISTIC) <- "Chi-squared"
  PARAMETER <- lags - 1
  names(PARAMETER) <- "df"
  PVAL <- stats::pchisq(STATISTIC, 
                        df = PARAMETER, lower.tail=FALSE)
  METHOD <- paste("ARCH LM-test; ", 
                  "Null hypothesis:  no ARCH effects")
  result <- list(statistic = STATISTIC,
                 parameter = PARAMETER, 
                 p.value = PVAL, method = METHOD, 
                 data.name = xName)
  class(result) <- "htest"
  return(result)
}

rates = read.table('收益率.csv', header=T, sep=',')
# ARCH效应检验
print(ArchTest(rates$SSEC, lags=10))
print(ArchTest(rates$SCI, lags=10))
print(ArchTest(rates$FTSE100, lags=10))
print(ArchTest(rates$DAX30, lags=10))
print(ArchTest(rates$CAC40, lags=10))
