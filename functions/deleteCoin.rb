def deleteCoinFromList(deleteCoinSymbol)

    # Input deleteCoinSymbol
    @coinSymbol = ((deleteCoinSymbol.sub!("/delete", "")).delete(' ')).downcase

    # Search coin in user list
    for userElement in @list do
    
        # Regex for symbol from json array
        symbol = (((userElement.to_json[/"symbol\":\"(.*?)\"/]).sub!('"symbol":"', '')).sub!('"',''))

        # If you want delete BTC, sent error
        if @coinSymbol == 'btc'
            @result = @messages["delete-message-btc"]
            break
        end

        # If symbol is in user list, delete it
        if @coinSymbol == symbol
            @list.delete(userElement)
            @result = @messages["delete-message-confirm"] 
                
                # Write list in JSON file
                File.open('jsons/list.json',"w") do |f|
                    f.write(@list.to_json)
                end
            
            break

            # If coin not found sent error message
            else @result = @messages["delete-message-cancel"]
        end
    end

end