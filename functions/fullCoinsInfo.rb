def fullCoinsInfo(fullCoinSymbol) 

    @coinSymbol = ((fullCoinSymbol.sub!("/full", "")).delete(' ')).downcase

    # Search coin in user list
    for userElement in @list do
    
        # Regex for symbol from json array
        symbol = (((userElement.to_json[/"symbol\":\"(.*?)\"/]).sub!('"symbol":"', '')).sub!('"',''))

        if @coinSymbol == symbol

            # Get uri from watch list
            url = ((userElement.to_json[/"url\":\"(.*?)\"/]).sub!('"url":"', '')).sub!('"','')
            coinName = ((userElement.to_json[/"name\":\"(.*?)\"/]).sub!('"name":"', "\nНазва монети: ")).sub!('"','')
            coinSymbol = "\nСимвол монети: " + (((userElement.to_json[/"symbol\":\"(.*?)\"/]).sub!('"symbol":"', "")).sub!('"','')).upcase

            # Message header
            header = "Повна інформація про: #{symbol.upcase}\n#{coinName} #{coinSymbol}"

            # API-Request for get coin price
            respons = apiRequest(url)

            # Market rank
            marketRank = (respons[/"market_cap_rank":(.*?),/]).sub!('"market_cap_rank":', "\n\nРейтинг ринкової капіталізації: #").sub!(',','')
                marketCap = (respons[/"market_cap":.*?"usd"(.*?),/])
                marketCap = marketCap[/"usd"(.*?),/].sub!('"usd":', "").sub!(',','')
                marketCap = "\nРинкова капіталізація: " + separator(marketCap) + ' $'

                market = marketRank + marketCap

            # Price
            coinPrice =  (respons[/"usd":(.*?),/]).sub!('"usd":', "").sub!(',','')
                coinPrice = "\n\nВартість монети: " + separator(coinPrice) + " $"

            # Change price
            changePrice24h = ((respons[/"price_change_percentage_24h":(.*?),/]).sub!('"price_change_percentage_24h":', "").sub(",",'')).to_f
                changePrice24h = "\n\nЗміна вартості за 24 години: #{changePrice24h.round(2)} %"
            changePrice7d = ((respons[/"price_change_percentage_7d":(.*?),/]).sub!('"price_change_percentage_7d":', "").sub(",",'')).to_f
                changePrice7d = "\nЗміна вартості за 7 днів: #{changePrice7d.round(2)} %"
            changePrice14d = ((respons[/"price_change_percentage_14d":(.*?),/]).sub!('"price_change_percentage_14d":', "").sub(",",'')).to_f
                changePrice14d = "\nЗміна вартості за 14 днів: #{changePrice14d.round(2)} %"
            changePrice30d = ((respons[/"price_change_percentage_30d":(.*?),/]).sub!('"price_change_percentage_30d":', "").sub(",",'')).to_f
                changePrice30d = "\nЗміна вартості за 30 днів: #{changePrice30d.round(2)} %"

                high24h = (respons[/"high_24h":.*?"usd"(.*?),/])
                high24h = high24h[/"usd"(.*?),/].sub!('"usd":', "").sub!(',','')
                high24h = "\n\nНийвища вартість за 24 години: " + separator(high24h) + ' $'

                low24h = (respons[/"low_24h":.*?"usd"(.*?),/])
                low24h = low24h[/"usd"(.*?),/].sub!('"usd":', "").sub!(',','')
                low24h = "\nНийнижча вартість за 24 години: " + separator(low24h) + ' $'

                price = coinPrice + changePrice24h + changePrice7d + changePrice14d + changePrice30d + high24h + low24h

            # Supply
            circulatingSupply =  (respons[/"circulating_supply":(.*?),/]).sub!('"circulating_supply":', "").sub!(',','')
                circulatingSupply = "\n\nВсього в обігу: " + supplyResult(circulatingSupply)

            totalSupply =  (respons[/"total_supply":(.*?),/]).sub!('"total_supply":', "").sub!(',','')
                totalSupply = "\nЗагальний запропонований обіг: " + supplyResult(totalSupply)

            maxSupply =  (respons[/"max_supply":(.*?),/]).sub!('"max_supply":', "").sub!(',','')
                maxSupply = "\nМаксимальний запропонований обіг: " + supplyResult(maxSupply)

                supply = circulatingSupply + totalSupply + maxSupply
        
            # Homepage
            homePage =  (respons[/"homepage":\["(.*?)"/]).sub!('"homepage":["', "\n\nДомашня сторінка проекту: ").sub!('"','')

            @result = header + market + price + supply + homePage
            break

            # If coin not found sent error message
            else @result = @messages["full-info-error"]
        end
    end

end

def separator(number, delimiter = ',')
    number.to_s.reverse.gsub(%r{([0-9]{3}(?=([0-9])))}, "\\1#{delimiter}").reverse
end

def supplyResult(inputNumber)
    if inputNumber == 'null'
        inputNumber = "немає інфо."
    else inputNumber = inputNumber.to_f.round
        inputNumber = separator(inputNumber)
    end
end