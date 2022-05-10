# Get data from JSON files

def database # Open coins database
    file = File.read('jsons/database.json')
    @database = JSON.parse(file)
end

def userList # Open user list
    file = File.read('jsons/list.json')
    @list = JSON.parse(file)
end

def getMessages # Get message 
    file = File.read('jsons/messages.json')
    @messages = JSON.parse(file)
end