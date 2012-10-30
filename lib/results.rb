require './lib/search.rb'
require './lib/post.rb'

class Results
  attr_reader :doc

  def initialize(html, url)
    @doc = html
    @search_url = url
  end

  def posts
    @posts = []
    @doc.css('p').each do |post|
      @posts << Post.new([post.at_css('a')[:href], post.css('span')[1].text, post.css('span')[5].text, post.css('span')[6].text[2...-1], post.css('a').text.downcase])
    end
    return @posts
  end

  def get_url(chunk)
    chunk.select{ |chunk| return chunk['href'] }
  end

end
#
search = Search.new("yankees")
puts search.results.posts[0].inspect
