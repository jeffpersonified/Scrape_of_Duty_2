require 'nokogiri'
require_relative 'search'
require_relative 'post'

class Results
  attr_reader :doc, :search_url

  def initialize(html, url)
    @doc = html
    @search_url = url
  end

  def post_attributes
    post_attributes = []
    @doc.css('p').each do |row|
      links = row.at_css('a')[:href]
      row.css('span')[1].text.strip == "-" ? date = row.css('span')[0].text : date = row.css('span')[1].text
      row.css('span')[5] != nil ? price = row.css('span')[5].text : price = "not listed"
      row.css('span')[6] != nil ? location = row.css('span')[6].text[2...-1] : location = "not provided"
      title = row.css('a')[0].text.downcase
      category = row.css('a')[1].text.downcase
      post_attributes << [links, date, price, location, title, category, @search_url]
    end
    post_attributes
  end

  def posts
    posts = []
    post_attributes.each { |row| posts << Post.new(row) }
    posts
  end

  def to_s
    posts.each { |post| puts "listing: #{post.title}\nurl: #{post.url}\n\n" }
  end
end

# search = Search.new("studio", "for sale")
# puts search.results.posts[4].inspect