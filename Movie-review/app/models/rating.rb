class Rating < ApplicationRecord

  #Association
  belongs_to :movie
  belongs_to :user

  #callbacks
  after_create :update_rating_average
  after_update :update_rating_average

  #update rating average method
  private
  def update_rating_average
    movie = self.movie
    average = movie.ratings.average(:value)
    movie.update(rating_average: average)
  end

end
