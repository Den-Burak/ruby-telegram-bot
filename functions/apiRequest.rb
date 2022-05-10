def apiRequest(url)

    uri = URI(url)
    req = Net::HTTP::Get.new(uri)
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http|http.request(req)}
    result = JSON.parse(response.body)
    result = result.to_json

end