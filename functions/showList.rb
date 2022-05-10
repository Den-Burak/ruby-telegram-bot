# Show user list
def showList

    # Default
    @string = @messages['your-list'] 

    # Get elements from array
    for element in @list do

        # Regex for elenemts from json-array
        coinName = ((element.to_json[/"name\":\"(.*?)\"/]).sub!('"name":"', '')).sub!('"','')
        coinSymbol = (((element.to_json[/"symbol\":\"(.*?)\"/]).sub!('"symbol":"', '')).sub!('"','')).upcase
        url = ((element.to_json[/"url\":\"(.*?)\"/]).sub!('"url":"', '')).sub!('"','')

            # API-Request for get coin price
            result = apiRequest(url)

        # Regex for coin price
        coinPrice = (result[/"usd":(.*?),/]).sub!('"usd":', '').sub!(',','')

        # Add elents in variable for print
        @string = @string + "#{coinName} - #{coinSymbol} - #{coinPrice}$\n"

    end

    # Add time for list message
    time = Time.new
    @string = @string + "\n#{@messages['time']} #{time.strftime("%d-%m-%Y %H:%M:%S")}"

end