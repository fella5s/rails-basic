class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :is_admin
  
  attr_accessor :password
  
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  
  validates_presence_of :email
  validates_uniqueness_of :email
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  
  before_create :not_admin
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
    
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end  
   
  def is_admin?
    self.is_admin
  end

  private

  def not_admin
    self.is_admin ||= 0
  end 
    
end
