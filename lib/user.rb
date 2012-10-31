#require_relative 'database'

class User
  attr_accessor :name, :username, :password, :email

  def initialize(name, password, username, email)
    @name = name
    @password = password
    @username = username
    @email = email
  end


end

# dani = User.new("Dani", "foobar", "mgrossmann", "michi@grossmann.com")
#CraigsDatabase.to_database(dani)
# p dani.from_database('users')
