require 'sqlite3'
require_relative 'database'


class User
  attr_reader :name, :username, :password, :email

  def initialize(name, username, password, email)
    @name = name
    @username = username
    @password = encrypt(password)
    # @email = email
    valid_email?(email) ? @email = email : raise("Invalid Email")
    @db = CraigsDatabase.new
  end

  def valid_email?(email)
    emails = CraigsDatabase.get_items('users', 'email').flatten(1)
    (email.match(/([a-zA-Z0-9]+)@([a-zA-Z0-9]+)\.([a-zA-Z]{2,4})/) ? true : false) && !emails.include?(email)
  end

  # def valid_new_user
  #    emails = []
  #    emails.include?(email) ?

  def encrypt(password)
    password
  end

end

# dani = User.new("Michael Grossmann", "mgrossmann", "foobar", "michi@grossmann.com")
# dani.to_database
# p dani.from_database('users')