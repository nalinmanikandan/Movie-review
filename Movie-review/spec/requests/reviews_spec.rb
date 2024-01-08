require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  include Devise::Test::IntegrationHelpers
  let(:user) { User.create(email: 'user@example.com', password: 'password') }
  let(:movie) { Movie.create(name: 'Example Movie', release_date: '2023-01-01') }

  before { sign_in(user) }

  describe 'GET #edit' do
    it 'renders the edit template' do
      review = Review.create(movie: movie, user: user, content: 'Test Content')
      get edit_movie_review_path(movie, review)
      expect(response).to render_template(:edit)
    end
  end

  describe 'GET #show' do
    it 'assigns all reviews to @reviews' do
      review = Review.create(movie: movie, user: user, content: 'Test Content')
      get movie_reviews_path(movie)
      expect(assigns(:reviews)).to eq([review])
    end

    it 'renders the show template' do
      get movie_reviews_path(movie)
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do
    it 'creates a new review' do
      expect {
        post movie_reviews_path(movie), params: { review: { content: 'New Review' } }
      }.to change(Review, :count).by(1)

      expect(response).to redirect_to(movie_path(movie))
      expect(flash[:notice]).to eq('Review saved successfully.')
    end
  end

  describe 'PATCH #update' do
    it 'updates the review' do
      review = Review.create(movie: movie, user: user, content: 'Old Content')
      patch movie_review_path(movie, review), params: { review: { content: 'Updated Content' } }
      expect(response).to redirect_to(movie_path(movie))
      expect(flash[:notice]).to eq('Review was successfully updated.')
      review.reload
      expect(review.content).to eq('Updated Content')
    end

    it 'renders edit template when update fails' do
      review = Review.create(movie: movie, user: user, content: 'Old Content')
      allow_any_instance_of(Review).to receive(:update).and_return(false)
      patch movie_review_path(movie, review), params: { review: { content: 'Updated Content' } }
      expect(response).to render_template(:edit)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the review' do
      review = Review.create(movie: movie, user: user, content: 'Test Content')
      expect {
        delete movie_review_path(movie, review)
      }.to change(Review, :count).by(-1)

      expect(response).to redirect_to(movies_path(movie))
      expect(flash[:notice]).to eq('Review was successfully destroyed.')
    end
  end
end
