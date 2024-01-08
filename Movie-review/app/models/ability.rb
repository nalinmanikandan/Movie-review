# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)
    can :read, Movie
    can :create, Movie
    can :update, Movie, user_id: user.id
    can :delete, Movie, user_id: user.id
    can :read, Review
    can :create, Review
    can :update, Review, user_id: user.id
    can :delete, Review, user_id: user.id
  end
end
