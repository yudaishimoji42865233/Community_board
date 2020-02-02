class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :topic, dependent: :destroy
  has_many :comment, dependent: :destroy
  has_many :vote, dependent: :destroy
  has_many :topic_likes, dependent: :destroy
  has_many :comment_likes, dependent: :destroy

  mount_uploader :image, ImageUploader

  validates :name, :email, :encrypted_password, presence: true
end
