require 'net/http'
require 'json'
require 'base64'
require 'github'
class CodeviewController < ApplicationController
    @github = nil
    def index
        @commits = []
        @error_message = ""
        @ERROR_CODE = "404"
        @repo = params[:repo]
        @path = params[:file]
        #For the moment
        @contents = {"status" => "404", "message": "File not found"}
        @single_commit = "A commit"
        @github = Github.new()
        #@single_commits = github.get_contents("http://www.example.com").body
        #@users = github.get_user()

        if @repo.to_s.empty? or @path.to_s.empty?
            @contents = {"status" => "404", "message": "File not found"}
        else
            all_commits = get_all_commits(@repo, @path)
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

    def get_all_commits repo, path
        commit_url = repo[/(.*\/)contents/, 1] + 'commits?path=' + path
        contents = @github.get_contents(commit_url)
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
