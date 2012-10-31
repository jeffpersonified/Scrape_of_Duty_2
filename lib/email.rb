require 'mail'
require './lib/database.rb'
 # to be decided
class Email
  attr_reader :sender, :body, :recipient, :password, :date, :keyword

  def initialize(user_id)
    @sender     = "scrape.of.duty@gmail.com"
    @password   = "scrapeofduty"
    @date       = DateTime.now
    @keyword    = "kittens" #
    @search_url = "craigslist.com" #
    @user       = CraigsDatabase.db_handler("SELECT name FROM users WHERE id = '#{user_id}';").flatten.to_s
    @recipient  = CraigsDatabase.db_handler("SELECT email FROM users WHERE id = '#{user_id}';").flatten.to_s
    @body       = CraigsDatabase.get_items("posts", "title", "post_url", "price", "neighborhood") # pending
    # p @body
    title = @body[0]
  end

  def to_s
    puts "#{@user},"
    puts "Your search for #{@keyword} on #{@date} produced the following results:\n"
    self.each { |post| puts "#{post[]} (#{post[]}) #{post[]} at #{post[]} in the #{post[]} category\n" }
    puts "Best,\n Scrape of Duty 2"
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

# class EmailHandler
#   db(user).each
#   Email.new(user.id)
#
# end
email = Email.new(1)
# username = 1
# p CraigsDatabase.db_handler("SELECT email FROM users WHERE id = '#{username}';")
p CraigsDatabase.db_handler("SELECT p.* FROM posts p JOIN searches s on (s.id = p.search_id) JOIN users u on (u.id=s.user_id) WHERE u.id = 1;")


# email.send