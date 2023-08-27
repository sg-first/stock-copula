import pandas as pd
import numpy as np
import scipy.stats as stats
from statsmodels.tsa.stattools import adfuller
from statsmodels.tsa.arima.model import ARIMA
import statsmodels.tsa.stattools as st

def self_JBtest(y):
    # 样本规模n
    n = y.size
    y_ = y - y.mean()
    """
    M2:二阶中心钜
    skew 偏度 = 三阶中心矩 与 M2^1.5的比
    krut 峰值 = 四阶中心钜 与 M2^2 的比
    """
    M2 = np.mean(y_**2)
    skew =  np.mean(y_**3)/M2**1.5
    krut = np.mean(y_**4)/M2**2
    """
    计算JB统计量，以及建立假设检验
    """
    JB = n*(skew**2/6 + (krut-3 )**2/24)
    pvalue = 1 - stats.chi2.cdf(JB,df=2)
    # print("偏度：",stats.skew(y),skew)
    # print("峰值：",stats.kurtosis(y)+3,krut)
    print("JB检验：",stats.jarque_bera(y))
    return np.array([JB,pvalue])

def AdfTest(seq):
    dftest = adfuller(seq, autolag='AIC')
    print('ADF检验', dftest)

def ARMA(seq):
    order_analyze = st.arma_order_select_ic(seq, max_ar=5, max_ma=5, ic=['aic'])
    # order_analyze.bic_min_order
    arma_model = ARIMA(seq, order=(1, 0, 0)).fit()
    print(arma_model)
    # print(arma_model.params)

sheets = ['SSEC', 'SCI', 'FTSE100', 'DAX30', 'CAC40']
ret = {}

for sheet in sheets:
    df = pd.read_excel('stock_prices.xlsx', sheet_name=sheet)
    close = df['close']
    rates = []
    for i in range(1, len(close)):
        rate = (close[i] - close[i-1]) / close[i-1]
        rates.append(rate)
    print(sheet)
    # self_JBtest(rates)  # JB检验
    print("JB检验：", stats.jarque_bera(rates))
    AdfTest(rates)  # ADF检验
    ret[sheet] = rates

writer = pd.ExcelWriter('收益率.xlsx')
for sheetName, close in ret.items():
    closeDf = pd.DataFrame({ 'close':close })
    closeDf.to_excel(writer, sheet_name = sheetName, index = False)
writer.save()