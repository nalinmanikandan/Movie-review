require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe 'associations' do
    it 'belongs to a movie' do
      rating = Rating.reflect_on_association(:movie)
      expect(rating.macro).to eq(:belongs_to)
    end

    it 'belongs to a user' do
      rating = Rating.reflect_on_association(:user)
      expect(rating.macro).to eq(:belongs_to)
    end
  end

  describe 'callbacks' do
    let(:user) { User.create!(email: 'example@gmail.com', password: 'example@1234', id: 1) }
    let(:movie) { Movie.create!(name: 'Example Movie', release_date: '2023-01-01', user: user) }

    it 'updates rating average after creation' do
      expect(movie.rating_average).to be_nil
      user.reload
      rating = Rating.create(movie: movie, user: user, value: 5)
      movie.reload
      expect(movie.rating_average).to eq(5.0)
    end

    it 'updates rating average after update' do
      rating = Rating.create(movie: movie, user: user, value: 4)
      movie.reload
      expect(movie.rating_average).to eq(4.0)
      rating.update(value: 3)
      movie.reload
      expect(movie.rating_average).to eq(3.5)
    end
  end
end
