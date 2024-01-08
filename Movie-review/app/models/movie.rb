class Movie < ApplicationRecord
  #associations
  has_many :ratings
  has_many :reviews
  belongs_to :user

  # scopes
  scope :by_release_date, ->(date) { where('release_date = ?', date) if date.present? }
  scope :by_movie_name, ->(name) { where('name LIKE ?', "%#{name}%") if name.present? }

  #validations
  validates :name, presence: true, uniqueness: true
  validates :release_date, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: "Date must be in the format YYYY-MM-DD" }

end
