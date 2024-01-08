require 'rails_helper'

RSpec.describe User, type: :model do
  it "has many ratings" do
    user = User.reflect_on_association(:ratings)
    expect(user.macro).to eq(:has_many)
  end

  it "has many reviews" do
    user = User.reflect_on_association(:reviews)
    expect(user.macro).to eq(:has_many)
  end

  it "is a valid user with valid attributes" do
    user = User.new(
      email: 'test@example.com',
      password: 'password123',
    # Add other required attributes here
      )
    expect(user).to be_valid
  end

  it "is not valid without an email" do
    user = User.new(email: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without a password" do
    user = User.new(password: nil)
    expect(user).to_not be_valid
  end
end
