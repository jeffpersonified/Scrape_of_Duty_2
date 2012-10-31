require_relative 'database'
require_relative 'account'
require_relative 'post'
require_relative 'search'
require_relative 'user'
require_relative 'results'

class Session
  def initialize
    @account = Account.new
  end

  def start
    puts "Type 'l' to login or 'r' to register"
    input = gets.chomp
    if input == 'l'
      login
    elsif input == 'r'
      register
    else
      start
    end
  end

  def login
    puts "Please Log In:"
    @username_input = gets.chomp
    @password_input = gets.chomp
    @account.login(username_input, password_input)
  end

  def authorize
    @account.find_user
    if @account.user_exists? == false
      puts "record not found, press 'r' to register"
      input = gets.chomp
      input == "r" ? register : login
    elsif @account.user_exists? && @account.logged_in != true
      puts "wrong password, please try again"
      login
    elsif @account.logged_in == true
      puts "You are now logged in"
    else
      puts "something went wrong with the #authorized method"
    end
  end

  def register
    puts "please enter your name:"
    name = gets.chomp
    puts "please select a username:"
    username = gets.chomp
    puts "please choose a password:"
    password = gets.chomp
    puts "please enter a valid email address:"
    email = gets.chomp
    validate_account
    @account.register_user(name, password, username, email)
  end

  def validate_account(username, password)
    if valid_username?(username) != true
      puts "username already in use"
      register
    elsif @account.valid_email?(email) != true
      puts "email already in use"
      register
    end
  end

end