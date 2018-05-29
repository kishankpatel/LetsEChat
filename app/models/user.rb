class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :messages
  has_many :conversations, foreign_key: :sender_id
  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups
end
