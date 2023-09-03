library(pracma)
library(copula)
source("CoVaRCopula/CoVaR.R")
source("CoVaRCopula/DynCopulaCoVaR.R")
source("CoVaRCopula/skewtdis_inv.R")

a = data.frame(df$SCI)
b = data.frame(df$SSEC)

df = read.table('收益率.csv', header=T, sep=',')
ret = CoVaR(0.05, 0.05, 0.99, 4.97, dof=0.1, cond.mean=a, cond.sigma=b, 
            dist='t', type = 'Student')
print(ret)
ret.covar = ret$CoVaR