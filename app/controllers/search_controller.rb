class SearchController < ApplicationController
	def search
		@range = params[:range]
		@keyword = params[:keyword]
		
		if @range == "User"
			@users = User.search(params[:search], params[:keyword])
		else
			@books = Book.search(params[:search], params[:keyword])
		end
	end
end