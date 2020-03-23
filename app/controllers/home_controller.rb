require 'net/http'
require 'json'
require 'github'


class HomeController < ApplicationController

	def index
		error = {"status" => "505", "message" => "Non-indentifiable repo."}
    query = params[:query]
    github = Github.new()

    if params[:type] == 'dir'
			@contents = github.get_contents(query)
			query = query[/(http|https):\/\/api.github.com\/repos\/([\w,\-,\_]*[\/][\w,\-,\_]*)/, 2]
    else  
			repo_and_user = parse_repo(query)
			@repo = repo_and_user
			if repo_and_user.nil? 
				@contents = error
			else
				url = 'https://api.github.com/repos/' + repo_and_user + '/contents'
				@contents = github.get_contents(url)
			end
    end        
  end

	def parse_repo query
        if query.to_s.empty?
            puts "Scenario 1"
            return nil
        end

        if query.include? "http://github.com/" or query.include? "https://github.com/"
					puts "Scenario 2"
					repo = query[/(http|https):\/\/github.com\/([\w,\-,\_]*[\/][\w,\-,\_]*)/, 2]
					if repo.split('/').length() < 2
						return nil
					end
					return repo
        elsif query.match(/^([\/][\w,\-,\_]*[\/][\w,\-,\_]*[\/])/)
					puts "Scenario 3"
					return query[1,query.length()-2]
				elsif query.match(/^([\/][\w,\-,\_]*[\/][\w,\-,\_]*)/)
					puts query
					puts "Scenario 4"
					return query[1,query.length()-1]
        elsif query.match(/^([\w,\-,\_]*[\/][\w,\-,\_]*[\/])/)
					puts "Scenario 5"
					return query[0, query.length()-1]
        elsif query.match(/^([\w,\-,\_]*[\/][\w,\-,\_]*)/)
					puts "Scenario 6"
					return query
        else 
					puts "Scenario 7"    
					return nil
		end
	end 
end
