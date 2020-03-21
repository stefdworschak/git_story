require 'uri'
require 'net/http'

class BasicAuthHTTP
  def self.new user, password
    @username = user     # Rails.application.credentials.github_api_user
    @password = password # Rails.application.credentials.github_api_token
  end

  def self.get_user
    return @username
  end

  def self.get_request url=nil, extra_fields=nil
    if not url.nil?
      @uri = URI.parse(url)
      http = Net::HTTP.new(@uri.host, @uri.port)
      req = Net::HTTP::Get.new(@uri.request_uri)
      http.use_ssl = (@uri.scheme == "https")
      if not extra_fields.nil?
        extra_fields.each do |header|
            req.add_field(header['field'], header['field_value'])
        end
      end
      req.basic_auth(@username, @password)
      res = http.request(req)
      return res
    else
      return nil
    end
  end
end # End Module