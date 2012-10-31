require 'mail'
require 'date'
require_relative 'database'
 # to be decided
class Email
  attr_reader :sender, :body, :recipient, :password, :date, :keyword

  def initialize(user_id)
    @sender     = "scrape.of.duty@gmail.com"
    @password   = "scrapeofduty"
    @date       = DateTime.now
    @keyword    = CraigsDatabase.db_handler("SELECT keyword FROM searches WHERE user_id = '#{user_id}'").flatten[0]
    @search_url = CraigsDatabase.db_handler("SELECT search_url FROM searches WHERE user_id = '#{user_id}' AND keyword = '#{@keyword}'").flatten[0]
    @user       = CraigsDatabase.db_handler("SELECT name FROM users WHERE id = '#{user_id}';").flatten[0]
    @recipient  = CraigsDatabase.db_handler("SELECT email FROM users WHERE id = '#{user_id}';").flatten[0]
    @body       = CraigsDatabase.get_items("posts", "title", "post_url", "price", "neighborhood") # pending
  end

  def compose_body
     string = "#{@user},\n\n"
     string << "Your search for #{@keyword}on #{@date.strftime('%F')} produced the following results:\n\n"
        @body.each_with_index { |post, i| string << "#{i+1}) #{post[0]} (#{post[1]}) #{post[2]} in #{post[3]}\n\n" }
     string << "Best,\n\nScrape of Duty 2"
     string
  end

  def send
    smtp = { :address => 'smtp.gmail.com', :port => 587,
             :domain => 'gmail.com', :user_name => @sender,
             :password => @password, :enable_starttls_auto => true,
             :openssl_verify_mode => 'none' }
    Mail.defaults { delivery_method :smtp, smtp }
    message = "To: #{@recipient}\r\nFrom: scrape.of.duty@gmail.com\r\nSubject: Your Craigslist Query Results\r\n\r\n#{compose_body}"
    mail = Mail.new(message)
    mail.deliver!
  end
end

email = Email.new(2)
email.send