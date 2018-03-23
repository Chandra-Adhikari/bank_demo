class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:user, :manager]
  mount_uploader :image, ImageUploader

  has_one :account, dependent: :destroy
  has_many :transactions, dependent: :destroy
  after_create :create_account
 
  def create_account
 	account_number = rand(10 ** 10)
 	ipin = SecureRandom.hex(4)
 	self.build_account(account_number: account_number, ipin: ipin).save
  end
end