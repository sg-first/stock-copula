import pandas as pd

sheets = ['SSEC', 'SCI', 'FTSE100', 'DAX30', 'CAC40']
ret = {}

for sheet in sheets:
    df = pd.read_excel('stock_prices.xlsx', sheet_name=sheet)
    close = df['close']
    rates = []
    for i in range(1, len(close)):
        rate = (close[i] - close[i-1]) / close[i-1]
        rates.append(rate)
    ret[sheet] = rates

saveDf = pd.DataFrame(ret)
saveDf.to_excel('收益率.xlsx', index = False)