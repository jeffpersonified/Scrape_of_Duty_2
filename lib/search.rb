require 'Nokogiri'
require 'open-uri'
require 'fakeweb'

class Search
  attr_accessor :region, :search_terms, :min_price, :max_price, :search_url

  def initialize(region="sfbay", max_price=1000000, min_price=0, search_terms)
    @region = region
    @search_terms = search_terms
    @min_price = min_price.to_s
    @max_price = max_price.to_s
    @search_url = "http://#{@region}.craigslist.org/search/sss?query=#{@search_terms}&srchType=A&minAsk=#{@min_price}&maxAsk=#{@max_price}"
  end

  def gen_html
    return Nokogiri::HTML(open(@search_url))
  end

  def results
    return Results.new(gen_html, @search_url)
  end

end

# search = Search.new("yankees")
# search.gen_html