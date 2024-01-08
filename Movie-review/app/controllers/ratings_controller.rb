class RatingsController < ApplicationController
  def create
    @movie = Movie.find(params[:movie_id])
    @rating = @movie.ratings.build(rating_params)
    @rating.user = current_user # Assuming you have user authentication in place
    existing_rating = current_user.ratings.find_by(movie: @movie)
    if @rating.save
      redirect_to @movie, notice: "Rating saved successfully."
    else
      redirect_to @movie, alert: "Rating couldn't be saved."
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:value)
  end
end