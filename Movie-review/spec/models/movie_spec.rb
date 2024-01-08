require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'associations' do
    it 'has many ratings' do
      movie = Movie.reflect_on_association(:ratings)
      expect(movie.macro).to eq(:has_many)
    end

    it 'has many reviews' do
      movie = Movie.reflect_on_association(:reviews)
      expect(movie.macro).to eq(:has_many)
    end
  end
  describe 'validations' do
    it 'validates presence of name' do
      movie = Movie.new
      expect(movie).not_to be_valid
      expect(movie.errors[:name]).to include("can't be blank")
    end
    it 'validates uniqueness of name' do
      user = User.create!(email: 'test@example.com', password: 'password')
      existing_movie = Movie.create!(name: 'Movie One', release_date: '2020-03-01', user: user)
      new_movie = Movie.new(name: 'Movie One', user: user)
      expect(new_movie).not_to be_valid
      expect(new_movie.errors[:name]).to include('has already been taken')
    end
  end

  describe 'scopes' do
    it 'filters by release date when date is present' do
      user = User.create!(email: 'test@example.com', password: 'password')
      movie1 = Movie.create!(name: 'movie1', release_date: '2023-01-01', user: user)
      movie2 = Movie.create!(name: 'movie2', release_date: '2023-01-02', user: user)
      result = Movie.by_release_date('2023-01-01')
      expect(result).to include(movie1)
      expect(result).not_to include(movie2)
    end

    it 'filters by movie name when name is present' do
      user = User.create!(email: 'test@example.com', password: 'password')
      movie1 = Movie.create!(name: 'Movie One', release_date: '2023-01-01', user: user)
      movie2 = Movie.create!(name: 'Another Movie', release_date: '2023-01-02', user: user)
      result = Movie.by_movie_name('Movie One')
      expect(result).to include(movie1)
      expect(result).not_to include(movie2)
    end

    it 'does not filter by release date when date is not present' do
      user = User.create!(email: 'test@example.com', password: 'password')
      movie1 = Movie.create(name: 'Movie 1', release_date: '2023-01-01', user: user)
      result = Movie.by_release_date(nil)
      expect(result).to include(movie1)
    end
  end

end
