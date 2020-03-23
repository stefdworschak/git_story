require 'basic_auth_http'
require 'json'

class Github
    def initialize
        @repo = nil
        @github_user = Rails.application.credentials.github_api_user
        @github_token = Rails.application.credentials.github_api_token
        BasicAuthHTTP.new(@github_user, @github_token)
    end

    def get_commits_for_file filename
      commits_url =  'https://api.github.com/repos/' + @repo + '/commits?path=' + filename
      all_commits = get_contents(commits_url)
      return all_commits
    end

    def get_single_commit filename, sha
      commit_url = 'https://api.github.com/repos/' + @repo + '/contents/' + filename + '?ref=' + sha
      single_commit = get_contents(commit_url)
      return single_commit
    end

    def get_file_contents download_url
      file_contents = get_contents(download_url, 'raw')
      if file_contents.body.strip() == '404: Not Found'
        file_contents = {"status" => "404", "message" => "File Not Found"}
      else
        file_contents = {"status" => "200", "message" => file_contents.body}
      end
      return file_contents
    end

    def set_repo repo
      @repo = repo
      return true
    end

    def get_user
        return @github_user
    end

    def get_contents url, response_type='json'
        #preview_header = [{"field" => "Accept", "field_value" => "application/vnd.github.cloak-preview"}]
        #response = BasicAuthHTTP.get_request(url, preview_header)
        response = BasicAuthHTTP.get_request(url)
        if response_type =='raw'
          return response
        else
          if response.nil? 
              error = {"status" => 505, "message" => "No url entered"}
              return error
          elsif response.code != '200'
              error = {"status" => response.code, "message" => response.message}
              return error
          end
          contents = {"status" => response.code, "message" => JSON.parse(response.body)}
          return contents
        end
    end

end # End Module