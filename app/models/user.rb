class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :encryptable, :confirmable, :lockable, :recoverable, :rememberable and :omniauthable
  devise :database_authenticatable, :token_authenticatable, :registerable,
         :timeoutable, :trackable, :validatable

  validates :password_confirmation, presence: true

  has_many :tasks
end
