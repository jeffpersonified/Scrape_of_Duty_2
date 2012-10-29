require './search.rb'
#require 'Nokogiri'
#require 'open-uri'

class Results

  def initialize(html)
    @doc = html
    @links = []
  end

  def css_links
    @docs.css('a')
  end

  def links
    css_links.select do |link|
      @links << link['href'] if /http:\/\/sfbay/.match(link['href'])
    end
    return @links[0...-1]
  end

end

search = Search.new("yankees")

puts search.results.links