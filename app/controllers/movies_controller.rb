class MoviesController < ApplicationController
  # This way I can use the rescue Error fix
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    movies = Movie.all
    render json: movies
  end
# How no to include values Using Active record serializer 
  def show
    movie = Movie.find(params[:id])

    # First approach
    render json: movie

    # Why is it all commented I'm using serializer 
    # .to_json(only: [:id, :tile, :year, :length, :director, :description, :poster_url, :category, :discount, :female_director])

    # Second approach render everything except
    # render json: movie.to_json(except: [:created_at, :updated_at])

  end
  # How to handle nested routes 
  # def show
  #   post = Post.find(params[:id])
  #   render json: post.to_json(only: [:title, :description, :id], include: [author: { only: [:name]}])
  # end

  # This way allow me to create a costum serializer and display all the data how I want to
  
  def summary 
    movie  = Movie.find(params[:id])
    render json: movie, serializer: MovieSummarySerializer
  end

  private

  def render_not_found_response
    render json: { error: "Movie not found" }, status: :not_found
  end
end
