class ReviewsController < ApplicationController
  before_action :set_movie
  load_and_authorize_resource

  def edit
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.find(params[:id])
  end

  def show
    @reviews = @movie.reviews
  end
  def create
    @review = @movie.reviews.build(review_params)
    @review.user = current_user # Assuming you have user authentication in place

    if @review.save
      redirect_to @movie, notice: "Review saved successfully."
    else
      redirect_to @movie, alert: "Review couldn't be saved."
    end
  end

  def update
      if @review.update(review_params)
        redirect_to movie_path(@movie), notice: "Review was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    if @review.destroy
      redirect_to movies_path(@movie), notice: "Review was successfully destroyed."
    end
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
