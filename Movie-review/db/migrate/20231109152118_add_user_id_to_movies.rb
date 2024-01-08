class AddUserIdToMovies < ActiveRecord::Migration[7.0]
  def change
    add_reference :movies, :user, foreign_key: true, default: 1
  end
end
