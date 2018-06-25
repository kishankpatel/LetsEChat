class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :messages
  # has_many :conversations, foreign_key: :sender_id
  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups
  has_many :images, as: :imageable, dependent: :destroy
  has_many :blocked_users, :foreign_key => :blocked_by , :class_name => "BlockedUser", dependent: :destroy
  def is_blocked_by id
    self.blocked_users.where(:blocked_to => id).present?
  end
  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def conversations
    Conversation.where("sender_id = :self_id OR recipient_id = :self_id", {self_id: self.id}) 
  end
end
