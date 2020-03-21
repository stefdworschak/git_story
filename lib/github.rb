require 'basic_auth_http'
class Github
    @error = {"status" => "404", "message": "File not found"}
    def initialize
        @github_user = Rails.application.credentials.github_api_user
        @github_token = Rails.application.credentials.github_api_token
        BasicAuthHTTP.new(@github_user, @github_token)
    end

    def greet
      return "Hello!"
    end

    def get_user
        return @github_user
    end

    def get_contents url
        preview_header = [{"field" => "Accept", "field_value" => "application/vnd.github.cloak-preview"}]
        response = BasicAuthHTTP.get_request(url, preview_header)
        if response.nil?
            return @error
        end
        return response.body
    end

end # End Module