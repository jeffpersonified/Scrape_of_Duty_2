require 'Nokogiri'
require 'open-uri'
require 'fakeweb'

class Search
  attr_accessor :region, :search_terms, :min_price, :max_price, :search_url
  VALID_CATEGORIES= Hash["community", "ccc", "events","eee", "gigs", "ggg", "housing", "hhh", "jobs", "jjj","personals", "ppp", "resumes", "rrr", "for sale", "sss", "services", "bbb"]


  def initialize(search_terms, category="for sale", region="sfbay", max_price=1000000)

    @region = region
    @search_terms = search_terms.gsub!("+", " ")
    @max_price = max_price.to_s
    @category = convert_category(category)
    @search_url = "http://#{@region}.craigslist.org/search/#{@category}?query=#{@search_terms}&srchType=A&minAsk=0&maxAsk=#{@max_price}"
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

  def results
    return Results.new(gen_html, @search_url)
  end

end
# #
# search = Search.new("maid", "housing")
# puts search.gen_html