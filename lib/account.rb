require_relative "database"

class Account
  attr_reader :logged_in

  def initialize
    @logged_in = false
    @exists = nil
  end

  def get_login(username, input_password)
    @username = username
    @input_password = input_password
  end

  def login(username, input_password)
    get_login(username, input_password)
    find_user
    @logged_in
  end

  def user_exists?
      @exists
  end

  def find_user
    user_row = CraigsDatabase.find_item(@username, 'username', 'users').flatten
    if user.empty?
      raise "user does not exist"
      @exists = false
    else
      @exists = true
      user_data(user_row)
    end
  end

  def user_data(user_row)
    @name = user_row[0]
    @email = user_row[3]
    password = user_row[1]
    check_password(password)
  end

  def check_password(password)
    if password == @input_password
      @user = User.new(@name, password, @username, @email)
      @logged_in = true
    else
      raise "Username and password do not match"
    end
  end

  def register_user(name, password, username, email)
    if valid_email?(email) && valid_username?(username)
      @user = User.new(name, password, username, email)
      CraigsDatabase.to_database(@user)
      @logged_in = true
    end
  end

  def valid_email?(email)
    CraigsDatabase.get_items("users", "email").flatten(1).include?(email)
  end

  def valid_username?(username)
   !CraigsDatabase.get_items("users", "username").flatten(1).include?(username)
  end
end



