class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :vote
  # has_many :topic, dependent: :destroy
  # has_many :comment
  mount_uploader :image, ImageUploader
end
