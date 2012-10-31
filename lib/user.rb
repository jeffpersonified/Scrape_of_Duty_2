require 'sqlite3'
require './lib/database.rb'


class User
  attr_reader :name, :username, :password, :email

  def initialize(name,password, username, email)
    @name = name
    @username = username
    @password = password
    @email = email
  end


end

# dani = User.new("Michael Grossmann", "mgrossmann", "foobar", "michi@grossmann.com")
# dani.to_database
# p dani.from_database('users')
