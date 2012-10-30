class Post
  attr_accessor :url, :date, :title, :price

  def initialize(array)
    @url = array[0]
    @date = Time.parse(array[1])
    @price = array[2].strip.to_i
    @location = array[3].strip
    @title = array[4].strip
  end
end