require 'net/http'
require 'json'
class HomeController < ApplicationController
  def index
    @query = params[:query]

    if not @query.to_s.empty?
        if params[:type] == 'dir'
            puts @query
            @response = Net::HTTP.get(URI.parse(@query))
            puts @response
        else  
            @query = @query.downcase.tr(" ", "_")
            @test = params[:query].split('')
            if @test[@test.length() - 1] != '/'
                @query.concat('/')
            end
            @response = Net::HTTP.get(URI.parse('https://api.github.com/repos/' + @query + 'contents'))
        end        
        @jsonContent = JSON.parse(@response)
        if @jsonContent.kind_of?(Array)
            @contents = {"message" => "200", "results" => @jsonContent}
        else
            @contents = @jsonContent
        end
    else
      @contents = JSON.parse('{"message": "Please enter an owner and repo."}')
    end
  end

	def parse_repo query
		if @repo.to_s.empty?
            return nil
        end
		if query.include? "http://" or query.include? "https://"
			return query
		elsif query.split('/').length() == 2
			return query += "/"
		elsif query.split('/').length() == 3
			return
		end
	end 
end
