
URL = 'https://www.coingecko.com/uk' # Web site url

# Start buttons
def startButtons
    startButtonsSelect = [
        Telegram::Bot::Types::InlineKeyboardButton.new(text: @messages['start-work'], callback_data: 'list-description'),
        Telegram::Bot::Types::InlineKeyboardButton.new(text: @messages['link-web-site'], url: URL)
    ]
    @startButtons = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: startButtonsSelect)
end

# Setting Buttons
def listButtons
    listButtonsSelect = [
        Telegram::Bot::Types::InlineKeyboardButton.new(text: @messages['list-reload'], callback_data: 'list'),
        Telegram::Bot::Types::InlineKeyboardButton.new(text: @messages['list-full-info'], callback_data: 'list-full-info'),
        Telegram::Bot::Types::InlineKeyboardButton.new(text: @messages['list-add-coin'], callback_data: 'list-add-coin'),
        Telegram::Bot::Types::InlineKeyboardButton.new(text: @messages['list-delete-coin'], callback_data: 'list-delete-coin'),
        Telegram::Bot::Types::InlineKeyboardButton.new(text: @messages['link-web-site'], url: URL)
    ]
    @listButtons = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: listButtonsSelect)
end

# Get list
def listOneButton
    listOneButtonSelect = [
        Telegram::Bot::Types::InlineKeyboardButton.new(text: @messages['list-get'], callback_data: 'list')
    ]
    @listOneButton = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: listOneButtonSelect)
end

# Back to button
def backToButton
    backToButtonSelect = [
        Telegram::Bot::Types::InlineKeyboardButton.new(text: @messages['back-to'], callback_data: 'list')
    ]
    @backToButton = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: backToButtonSelect)
end