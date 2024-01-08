require 'rails_helper'

RSpec.describe "Ratings", type: :request do
  include Devise::Test::IntegrationHelpers
  let(:user) { User.create(email: 'user@example.com', password: 'password') } # Adjust attributes as per your User model
  let!(:movie) { Movie.create(name: 'Example Movie', release_date: '2023-01-01' ) } # Adjust attributes as per your Movie model
  let(:valid_attributes) { { value: 5 } }

  before { sign_in(user) }

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new rating' do
        expect {
          post movie_ratings_url(movie), params: { movie_id: movie.id, rating: valid_attributes }
        }.to change(Rating, :count).by(1)

        expect(response).to redirect_to(movie_path(movie))
        expect(flash[:notice]).to eq('Rating saved successfully.')
      end
    end

    context 'with an existing rating' do
      let!(:existing_rating) { Rating.create(user: user, movie: movie, value: 3) }

      it 'updates the existing rating' do
        expect {
          post :create, params: { movie_id: movie.id, rating: valid_attributes }
        }.to_not change(Rating, :count)

        existing_rating.reload
        expect(existing_rating.value).to eq(valid_attributes[:value])
        expect(response).to redirect_to(movie_path(movie))
        expect(flash[:notice]).to eq('Rating already added')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { value: 6 } }

      it 'does not create a new rating' do
        expect {
          post :create, params: { movie_id: movie.id, rating: invalid_attributes }
        }.to_not change(Rating, :count)

        expect(response).to redirect_to(movie_path(movie))
        expect(flash[:alert]).to eq("Rating couldn't be saved.")
      end
    end
  end
end
