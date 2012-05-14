class User < ActiveRecord::Base
  domain = Rails.configuration.song_archive_allowed_mail_domain
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,# :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :nickname, :email, :password, :password_confirmation, :remember_me
  
  validates :nickname, :presence => true, :uniqueness => true
  validates :email, :format => {
    :with => Regexp.new('.*(@' + domain + ')'),
    :message => :incorrect_mail_domain,  # :message => 'Please use your ' + domain + ' email address'
    :domain => domain
  }
end
