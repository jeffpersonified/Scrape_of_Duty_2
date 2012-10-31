class Post
  attr_accessor :url, :date, :title, :price, :location

  def initialize(array)
    @url      = array[0]
    @date     = Time.parse(array[1])
    @price    = array[2].empty? ? "not_listed" : array[2].strip[1..-1].to_i
    @location = array[3].strip
    @title    = array[4].strip
    @category = array[5].strip
    @search_url = array[6]
  end
end