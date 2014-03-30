class User < ActiveRecord::Base

  attr_accessor :password
  attr_accessible :username, :email, :password, :password_confirmation, :encrypted_password, :password_digest


  validates :username, :presence => true,
  :uniqueness => true
  validates :email,    :presence => true,
  :uniqueness => true,
  :format => { :with => /\w+@\w+\.\w+/ }
  validates :password, :confirmation => true
  validates :password_confirmation, presence: true

  before_save { |user| user.email = email.downcase }
  before_save {:encrypt_password }

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = User.find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  private

  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end



end
