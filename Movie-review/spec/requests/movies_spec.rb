require 'rails_helper'

RSpec.describe "/movies", type: :request do
  include Devise::Test::IntegrationHelpers
  let(:user) { User.create!(email: 'test@example.com', password: 'password') }
  let(:valid_attributes) { { name: 'The Movie', release_date: '2022-01-01', user: user } }
  let(:invalid_attributes) { { name: nil, release_date: '2023-01-01', user: user } }

  describe "GET /index" do
    it "renders a successful response" do
      Movie.create!(valid_attributes)
      get movies_url
      expect(response).to be_truthy
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      movie = Movie.create!(valid_attributes)
      get movie_url(movie)
      expect(response).to be_truthy
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_movie_url
      expect(response).to be_truthy
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      movie = Movie.create!(valid_attributes)
      get edit_movie_url(movie)
      expect(response).to be_truthy
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Movie" do
        movie = Movie.create!(valid_attributes)
        created_movie = Movie.last
        expect(created_movie.name).to eq(valid_attributes[:name])
      end

      it "redirects to the created movie" do
        post movies_url, params: { movie: valid_attributes }
        expect(response).to redirect_to(movie_url(Movie.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Movie" do
        expect {
          post movies_url, params: { movie: invalid_attributes }
        }.to change(Movie, :count).by(0)
      end

      it "renders a response with 422 status (i.e., to display the 'new' template)" do
        post movies_url, params: { movie: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { { name: 'Updated Movie', release_date: '2023-01-01' } }
      it "updates the requested movie" do
        movie = Movie.create!(valid_attributes)
        patch movie_url(movie), params: { movie: new_attributes }
        movie.reload
        expect(movie.name).to eq('Updated Movie')
      end

      it "redirects to the movie" do
        movie = Movie.create!(valid_attributes)
        sign_in user
        patch movie_url(movie), params: { movie: new_attributes }
        movie.reload
        expect(response).to redirect_to(movie_url(movie))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e., to display the 'edit' template)" do
        movie = Movie.create!(valid_attributes)
        patch movie_url(movie), params: { movie: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested movie" do
      movie = Movie.create!(valid_attributes)
      sign_in user
      expect {
        delete movie_url(movie)
      }.to change(Movie, :count).by(-1)
    end

    it "redirects to the movies list" do
      movie = Movie.create!(valid_attributes)
      sign_in user
      delete movie_url(movie)
      expect(response).to redirect_to(movies_url)
    end
  end
end
