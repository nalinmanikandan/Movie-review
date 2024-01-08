class User < ApplicationRecord

  #associations
  has_many :ratings
  has_many :reviews
  has_many :movies
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
