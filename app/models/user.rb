class User < ApplicationRecord
  acts_as_booker
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z0-9\-.]+\.[a-z]+\z/i }
  validates :encrypted_password, presence: true, length: { minimum: 6 }
end
