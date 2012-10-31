require_relative 'database'

class Post
  attr_accessor :post_url, :posted_at, :price, :neighborhood, :title, :category, :search_url

  def initialize(array)
    @post_url      = array[0]
    @posted_at = Time.parse(array[1])
    @price    = array[2].empty? ? "not_listed" : array[2].strip[1..-1].to_i
    @neighborhood = array[3]
    @title    = array[4]
    @category = array[5]
    @search_url = array[6]
  end

  def to_db
    CraigsDatabase.to_database(self)
  end
end

post = Post.new(['oudhsjfhksd','2012-10-30',"100","ebnr","ber","gre","http://sfbay.craigslist.org/search/sss?query=futon&srchType=A&minAsk=0&maxAsk=1000000"])
post.to_db

# test = "http://sfbay.craigslist.org/search/hhh?query=driver&srchType=A&minAsk=0&maxAsk=1000000"
# puts test.length