class User < ActiveRecord::Base
  
  # Give a static short-hand for the legit mail domain for use int templates etc.
  def self.domain
    return Rails.configuration.song_archive_allowed_mail_domain
  end
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,# :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :nickname, :email, :password, :password_confirmation, :remember_me
  
  validates :nickname, :presence => true, :uniqueness => true
  
  # Email must have a certain domain name, which can be configured.
  # I.e. email must end with @legitdomain.foo
  validates :email, :format => {
    :with => Regexp.new('.*(@' + domain + ')'),
    :message => :incorrect_mail_domain,
    :domain => domain
  }
  
end
