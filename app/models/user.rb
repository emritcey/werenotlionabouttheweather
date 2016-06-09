class User < ActiveRecord::Base
  # Remember to create a migration!
  validates :username, presence: true
  validate :validate_password

  include BCrypt

  def password
    @password ||= Password.new(hashed_password)
  end

  def password=(new_password)
    @new_password = new_password
    password = Password.create(new_password)
    self.hashed_password = password
  end

  def authenticate(pass)
    self.password == pass
  end

  def validate_password
    if @new_password.length < 1
      self.errors.add(:password, "is too short!")
    end 
  end 

end
