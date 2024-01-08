require 'rails_helper'

RSpec.describe Review, type: :model do
  it "belongs to a movie" do
    review = Review.reflect_on_association(:movie)
    expect(review.macro).to eq(:belongs_to)
  end

  it "belongs to a user" do
    review = Review.reflect_on_association(:user)
    expect(review.macro).to eq(:belongs_to)
  end

  it "is valid with valid attributes" do
    user = User.create(email: 'test@example.com', password: 'password123')
    movie = Movie.create(name: 'Sample Movie', release_date: '2023-01-01')
    review = Review.new(
      content: 'This is a sample review',
      user: user,
      movie: movie
    )
    expect(review).to be_valid
  end

  it "is not valid without content" do
    review = Review.new(content: nil)
    expect(review).to_not be_valid
  end
end
