require_relative 'functions/conectionJSON.rb' # Get json elements
require_relative 'functions/apiRequest.rb' # Sent api request
require_relative 'functions/addCoins.rb' # Add coins in user list
require_relative 'functions/deleteCoin.rb' # Add coins in user list
require_relative 'functions/fullCoinsInfo.rb' # Info about coins
require_relative 'functions/callbackButtons.rb' # Callbackk buttons under messages
require_relative 'functions/showList.rb' # List message

require 'telegram/bot'
require 'rubygems'
require 'open-uri'
require 'net/http'
require 'json'

class CryptoBot

  TOKEN = '5344392883:AAFKaTxwxL4sJwN3zx11OB8QvYSwqoYrKD0' # Token

  def botLisening

    getMessages # Get text of messages 
    database # Coins database
    userList # user list

  Telegram::Bot::Client.run(TOKEN) do |bot|
    bot.listen do |message|
      case message 

        when Telegram::Bot::Types::Message
          case message.text

            # Start bot
            when '/start'
              startButtons
                bot.api.send_message(chat_id: message.chat.id, text: "#{@messages["hello-message"]}", reply_markup: @startButtons)

            # Show user list    
            when '/list'
              showList
              listButtons
                  bot.api.send_message(chat_id: message.chat.id, text: "#{@string}", reply_markup: @listButtons)

            # Add coin in user list
            when /\/add(.*?)/
              addCoinInList(message.text)
                bot.api.send_message(chat_id: message.from.id, text: "#{@messages["add-message-selected"]} #{@coinSymbol.upcase}")
                listOneButton
                    bot.api.send_message(chat_id: message.from.id, text: "#{@result}", reply_markup: @listOneButton)

            # Add coin in user list
            when /\/delete(.*?)/
              deleteCoinFromList(message.text)
                bot.api.send_message(chat_id: message.from.id, text: "#{@messages["delete-message-selected"]} #{@coinSymbol.upcase}")
                listOneButton
                    bot.api.send_message(chat_id: message.from.id, text: "#{@result}", reply_markup: @listOneButton)

            # Full info about coin
            when /\/full(.*?)/
              fullCoinsInfo(message.text)
                listOneButton
                  bot.api.send_message(chat_id: message.from.id, text: "#{@result}", reply_markup: @listOneButton)

            # Show user list    
            when '/help'
              listOneButton
                  bot.api.send_message(chat_id: message.chat.id, text: "#{@messages["help"]}", reply_markup: @listOneButton)
                        
          end

        when Telegram::Bot::Types::CallbackQuery
          case message.data

              # Show list description
              when 'list-description'
                listOneButton
                  bot.api.send_message(chat_id: message.from.id, text: "#{@messages["list-description"]}", reply_markup: @listOneButton)

              # Show list
              when 'list'
                showList
                listButtons
                  bot.api.send_message(chat_id: message.from.id, text: "#{@string}", reply_markup: @listButtons)

              # Add coin description    
              when 'list-add-coin'
                backToButton
                  bot.api.send_message(chat_id: message.from.id, text: "#{@messages["list-add-description"]}", reply_markup: @backToButton)

              # Delete coin description
              when 'list-delete-coin'
                backToButton
                  bot.api.send_message(chat_id: message.from.id, text: "#{@messages["list-delete-description"]}", reply_markup: @backToButton)

              # Full info about coin
              when 'list-full-info'
                backToButton
                  bot.api.send_message(chat_id: message.from.id, text: "#{@messages["list-info-message"]}", reply_markup: @backToButton)
      
          end
        end
      end
    end
  end
    
  # Start bot
  def starting
    botLisening
  end
            
end
            
obj = CryptoBot.new
obj.starting