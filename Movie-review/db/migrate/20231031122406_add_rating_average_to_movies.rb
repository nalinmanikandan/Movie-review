class AddRatingAverageToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :rating_average, :float
  end
end
