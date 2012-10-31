require 'mail'
# require './lib/database.rb'
 # to be decided
class Email
  attr_reader :sender, :body, :recipient

  def initialize
    @sender     = "scrape.of.duty@gmail.com"
    @password   = "scrapeofduty"
    @date       = DateTime.now #
    @keyword    = "kittens" # =^..^=
    @search_url = "craigslist.com" #
    @user       = "Test" #CraigsDatabase.get_items("users", "name")
    @recipient  = @sender #CraigsDatabase.get_items("users", "email")
    @body       = "hello world" # CraigsDatabase.get_items("posts", "title", "url", "price", "neighborhood", "category") # pending
  end

  def to_s
    puts "#{@user},"
    puts "Your search for #{@keyword} on #{@date} produced the following results:\n"
    self.each { |post| puts "#{post.title} (#{post.post_url}) #{post.price} at #{post.neighborhood} in the #{post.category} category\n" }
    puts "Best,\n Scrape of Duty"
  end

  def send
    smtp = { :address => 'smtp.gmail.com', :port => 587,
             :domain => 'gmail.com', :user_name => @sender,
             :password => @password, :enable_starttls_auto => true,
             :openssl_verify_mode => 'none' }
    Mail.defaults { delivery_method :smtp, smtp }
    message = "To: #{@recipient}\r\nFrom: scrape.of.duty@gmail.com\r\nSubject: Your Craigslist Query Results\r\n\r\n#{@body.to_s}"
    mail = Mail.new(message)
    mail.deliver!
  end
end


email = Email.new
email.send