require 'Nokogiri'
require 'open-uri'
require 'fakeweb'
require_relative 'user'
# require_relative 'results'
# require_relative 'post'
require_relative 'database'


class Search
  attr_accessor :region, :keyword, :max_price, :category, :search_url, :username

  VALID_CATEGORIES= Hash["community", "ccc", "events","eee", "gigs", "ggg", "housing", "hhh", "jobs", "jjj","personals", "ppp", "resumes", "rrr", "for sale", "sss", "services", "bbb"]


  def initialize(keyword, category="for sale", region="sfbay", max_price=1000000)
    @region = region
    @keyword = keyword
    @max_price = max_price.to_s
    @category = convert_category(category)
    @search_url = "http://#{@region}.craigslist.org/search/#{@category}?query=#{@keyword.gsub('+', ' ')}&srchType=A&minAsk=0&maxAsk=#{@max_price}"
  end

  def valid_category?(category)
    VALID_CATEGORIES.has_key?(category)
  end

  def convert_category(category)
    if valid_category?(category)
      VALID_CATEGORIES.each {|key, value| return value if key == category}
    else
      puts "not valid bro"
    end
  end

  def gen_html
    return Nokogiri::HTML(open(@search_url))
  end

  def add_user(username)
    @username = username
  end

  def results
    return Results.new(gen_html, @search_url)
  end
  #{object.search_url}', '#{object.category}', '#{object.region}',
  # '#{object.min_price}', '#{object.max_price}', '#{object.keyword}',
  def to_db
    CraigsDatabase.to_database(self)
  end

end
# #
search = Search.new("appartment", "housing")
search.add_user("pantheman")
CraigsDatabase.to_database(search)
# puts search.gen_html