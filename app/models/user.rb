require './lib/mailchimp.rb'
class User < ActiveRecord::Base


  # Schema - Users Table
  # name - string
  # email - string INDEX
  # created_at - datetime
  # updated_at - datetime
  # password_digest - string
  # remember_token - string INDEX
  # admin - boolean default: false
  # avatar - string


  require 'carrierwave/orm/activerecord'
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}
  validates :password, length: { minimum: 6 }, :on => :create
  has_secure_password

  before_save { self.email = email.downcase }
  before_create :create_remember_token
  after_create :subscribe_to_mailing_list
  before_destroy :unsubscribe_from_mailing_list

  has_many :updates, foreign_key: "author_id"
  has_many :tutorials, foreign_key: "author_id"
  has_many :workers
  has_many :tasks, through: :workers
  has_many :memberships
  has_many :subteams, through: :memberships
  has_many :teams, through: :memberships
  has_many :weekly_awards

  mount_uploader :avatar, AvatarUploader

  def User.new_remember_token
  	SecureRandom.urlsafe_base64
  end

  def User.digest(token)
  	Digest::SHA1.hexdigest(token.to_s)
  end

  def subscribe_to_mailing_list
    mailchimp = Mailchimp.new
    begin
      mailchimp.subscribe(self.email, self.name)
    rescue Gibbon::MailChimpError => e
      puts e
    end

  end

  def unsubscribe_from_mailing_list
    mailchimp = Mailchimp.new
    begin
      mailchimp.unsubscribe(self.email)
    rescue Gibbon::MailChimpError => e
      puts e
    end
  end

  private

  	def create_remember_token
  		self.remember_token = User.digest(User.new_remember_token)
  	end
end
