load('s3Garch.RData')

SSEC_GARCH_Res = residuals(SSEC_GARCH,standardize=TRUE)
SCI_GARCH_Res = residuals(SCI_GARCH,standardize=TRUE)
FTSE100_GARCH_Res = residuals(FTSE100_GARCH,standardize=TRUE)
DAX30_GARCH_Res = residuals(DAX30_GARCH,standardize=TRUE)
CAC40_GARCH_Res = residuals(CAC40_GARCH,standardize=TRUE)

SSEC_PIT = pstd(SSEC_GARCH_Res)
SCI_PIT = pstd(SCI_GARCH_Res)
FTSE100_PIT = pstd(FTSE100_GARCH_Res)[1:2917]
DAX30_PIT = pstd(DAX30_GARCH_Res)[1:2917]
CAC40_PIT = pstd(CAC40_GARCH_Res)[1:2917]

df = data.frame(SSEC_PIT, SCI_PIT, FTSE100_PIT, DAX30_PIT, CAC40_PIT)
print(cor(df, method = "kendall"))
library(psych)
print(pairs.panels(df))