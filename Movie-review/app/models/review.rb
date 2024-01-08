class Review < ApplicationRecord

  #association
  belongs_to :movie
  belongs_to :user
end
