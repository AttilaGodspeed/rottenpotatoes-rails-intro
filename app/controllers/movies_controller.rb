class MoviesController < ApplicationController

#
#THE HEORKU APP SITE IS NOT UPDATING
#10/24/2016
#Giving me an apllication error when trying to check Heorku still (10/25/2016)
#Going to try to get it to work on my Heorku, if I get it to work, I will post link
#link is posted in Readme
#UPDATE: I'm still working on my Heorku. As of 10:45, if you summit the new link in the readme, you will get 107/308 points.
#I'm still working on it now. So that score should go up by due date

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #@all_ratings = ['G', 'PG', 'PG-13', 'R', 'NC-17'] #Movie.getRatings
    @all_ratings = Movie.get_possible_ratings
    session[:filtered_ratings] = @all_ratings
    
    # If user has specified 1 or more ratings, then update session ratings
    unless params[:ratings].nil?
      #@filtered_ratings = params[:ratings].keys
      #session[:filtered_ratings] = @filtered_ratings
      session[:filtered_ratings] = params[:ratings].keys
    end
    
    # If the user has specified a sorting mechanism, update session sorting mechanism
    #if params[:sort_by].nil?
    # If user didn't specify a sorting mechanism, then we're going to sort by the
    # sorting mechanism in our sessions
    #else
    #  session[:sort_by] = params[:sort_by]
    #end
    
    if !params[:sort_by].nil?
      session[:sort_by] = params[:sort_by]
    end
   
    @movies = Movie.all
    if !params[:ratings].nil?
    #if !session[:filtered_ratings].nil?
      #@movies = @movies.select{ |movie| session[:filtered_ratings].include? movie.rating }
      @movies = @movies.select{ |movie| params[:ratings].keys.include? movie.rating }
    end
    
    
    # title_sort symbol was placed in the params
    if params[:sort_by] == "title"
      #@movies = Movie.order("title asc")
      @movies = @movies.order(" title asc")
      #@movies = @movies.sort {|a,b| a.title <=> b.title}
      @movie_highlight = "hilite" 
    elsif params[:sort_by] == "release_date" 
      @movies = Movie.order("release_date asc")
      #@movies = @movies.sort {|a,b| a.release_date <=> b.release_date}
      @date_highlight = "hilite" 
    #else 
      #@movies = Movie.all
      # @movies = Movie.where(rating: 'G')
    end
    #Had to comment out your code, this sould get the ratings (does not as of 24 Oct)
    #@all_ratings = Movie.get_possible_ratings()
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
end
