require 'net/http'
require 'json'
require 'base64'
require 'github'
class CodeviewController < ApplicationController
    @github = nil
    def index
        commits = []
        @error_message = ""
        @ERROR_CODE = "404"
        @error = {"status" => "404", "message": "File not found"}
        @repo = params[:repo]
        @path = params[:file]
        #For the moment
        @contents = {"status" => "404", "message": "File not found"}
        @single_commit = "A commit"
        @github = Github.new()

        if @repo.to_s.empty? or @path.to_s.empty?
          @contents = @error
        else
					@github.set_repo @repo
					all_commits = @github.get_commits_for_file(@path)
          if all_commits['status'] == '200'
            file_commits = []
            count = all_commits['message'].length-1
            all_commits['message'].each do |commit|
              commit_details = {
                'id' => count,
                'timestamp' => commit['commit']['committer']['date'],
                'name' => @path,
                'sha' => commit['sha'],
                'author' => commit['author'],
                'committer' => commit['committer'],
                'message' => commit['commit']['message']
              } 
              single_commit = @github.get_single_commit(@path, commit['sha'])
              if single_commit.nil? or all_commits['status'] != '200'
                commit_details['download_url'] = 'N/A'
                commit_details['content'] = 'File content not found'
                commits.push(commit_details)
              else
                download_url = single_commit['message']['download_url']
                download_content = @github.get_file_contents(download_url)
                if download_content.nil? or download_content['status'] != '200'
                  commit_details['download_url'] = download_url
                  commit_details['content'] = 'File content not found'
                else
                  commit_details['download_url'] = download_url
                  commit_details['content'] = download_content['message']
                end
                commits.push(commit_details)
                count -= 1
              end
            end
            @contents = {'status' => '200', 'message' => commits.reverse()}
					else
            commits_error = @error
            commits_error['message'] = 'No commits found for the file in the specified repo'
            @contents = commits_error
					end
        end

        #if @repo.to_s.empty? or @path.to_s.empty?
        #    @contents = {"status" => "404", "message": "File not found"}
        #else
        #    @commit_url = @repo[/(.*\/)contents/, 1] + 'commits?path=' + @path
        #    @contents = get_contents(@commit_url)
        #    if @contents['message'] == '200'
        #        for commit in @contents['results']
        #            @sha = commit['sha']
        #            @single_commit_url = @repo[/(.*\/contents\/)/, 1] + @path + '?ref=' + @sha
        #            @single_commit = get_contents(@single_commit_url)
        #            if @single_commit['message'] == '200'
        #                @commit_content_b64 = get_contents(@single_commit_url)
        #                @commit_content = Base64.decode64(@commit_content_b64['content'])
        #                puts @commit_content
        #            else
        #                @single_commits = {'message':'400'}
        #            end
        #        end
        #    else
        #       @single_commits = {'message':'400'}
        #    end
        #end
        #@response = 0
    end

    def get_download_url url

    end

    def get_content_from_download_url url

    end


    def get_contents(url)
        @response = Net::HTTP.get(URI.parse(url))
        @jsonContent = JSON.parse(@response)
        if @jsonContent.kind_of?(Array)
            @contents = {"message" => "200", "results" => @jsonContent}
        else 
            @contents = @jsonContent
        end
        return @contents
    end
end
