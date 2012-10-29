require 'Nokogiri'
require 'open-uri'


class Search
  attr_accessor :region, :search_term, :min_price, :max_price

  def initialize(region="sfbay", max_price=1000000, min_price=0, search_terms)
    @region = region
    @search_terms = search_terms
    @min_price = min_price.to_s
    @max_price = max_price.to_s
  end

  def gen_html
    return Nokogiri::HTML(open("http://#{@region}.craigslist.org/search/sss?query=#{@search_terms}&srchType=A&minAsk=#{@min_price}&maxAsk=#{@max_price}"))
  end

  def results
    return Results.new(gen_html)
  end

end

search = Search.new("yankees")
puts search.gen_html
#puts search.gen_results_links





