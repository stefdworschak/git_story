require 'basic_auth_http'
class Github
    def initialize
        @github_user = Rails.application.credentials.github_api_user
        @github_token = Rails.application.credentials.github_api_token
        BasicAuthHTTP.new(@github_user, @github_token)
    end

    def get_commits_for_file repo, filename
      commits_url = repo[/(.*\/)contents/, 1] + 'commits?path=' + filename
      contents = get_contents(commits_url)
      puts contents
    end

    def greet
      return "Hello!"
    end

    def get_user
        return @github_user
    end

    def get_contents url
        #preview_header = [{"field" => "Accept", "field_value" => "application/vnd.github.cloak-preview"}]
        #response = BasicAuthHTTP.get_request(url, preview_header)
        response = BasicAuthHTTP.get_request(url)
        if response.nil? or response.code != 200
            error = {"status" => response.code, "message" => response.message}
            return error
        end
        contents = {"status" => response.code, "message" => response.body}
        return contents
    end

end # End Module