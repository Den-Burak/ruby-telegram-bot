# Search coin in user list
def addCoinInList(addCoinSymbol)

    # Default
    @result = true

    # Input addCoinSymbol
    @coinSymbol = ((addCoinSymbol.sub!("/add", "")).delete(' ')).downcase

    # Check repeat this coin in user list
    for userElement in @list do

        # Regex for symbol from json array
        symbol = (((userElement.to_json[/"symbol\":\"(.*?)\"/]).sub!('"symbol":"', '')).sub!('"',''))

        # If symbol is in your user list, return repeat message
        if @coinSymbol == symbol
                @result = @messages["add-message-repeat"] 
                break
        end

    end

    # If coin not found in user list, search coin in database
    if @result == true
        searchCoinInDatabase
    end

end

# Search coin in database
def searchCoinInDatabase

    for element in @database do

        # Regex for symbol from json array
        symbol = (((element.to_json[/"symbol\":\"(.*?)\"/]).sub!('"symbol":"', '')).sub!('"',''))
            
            # If coin is in database, add it in user list
            if @coinSymbol == symbol
                @list.append(element)
                @result = @messages["add-message-confirm"] 

                    # Write list in JSON file
                    File.open('jsons/list.json',"w") do |f|
                        f.write(@list.to_json)
                    end

                break
            
            # If not found coin in database, send error meassage
            else @result = @messages["add-message-cancel"] 

        end
    end
end