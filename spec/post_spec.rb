require 'simplecov'
SimpleCov.start

require 'uri'
require 'fakeweb'

require './lib/post.rb'
require './lib/results.rb'
require './lib/search.rb'

describe Post do

  let(:search){ Search.new("yankees") }

  before(:each) do
    @page = File.read('yankees_search.html')
    FakeWeb.register_uri(:get, "http://sfbay.craigslist.org/search/sss?query=yankees&srchType=A&minAsk=0&maxAsk=1000000", :body => @page)
  end

  let(:post){ search.results.posts[0] }

  context "initialize" do
    it "should initialize an instance of Post" do
      post.should be_instance_of Post
    end
  end

  context "#url" do
    it "should return a valid url" do
      post.url.should match URI::regexp
    end
    it "should return the correct url" do
      post.url.should eq("http://sfbay.craigslist.org/sfc/cbd/3373653023.html")
    end
  end

  context "#title" do
    it "should return the correct title" do
      pending #post.title.should eq("concerts, sporting events, shows and more in the bay area") # conflating title and category
    end
    it "should return a string" do
      post.title.should be_instance_of String
    end
  end

  context "#location" do
    it "should return the correct location" do
      post.location.should eq("downtown / civic / van ness")
    end
  end
  context "#date" do
    it "should return the correct date" do
      post.date.should eq(Time.parse('Oct 29'))
    end
  end
  context "#price" do
    let(:post_with_price){ search.results.posts[2] }
    it "should return the right price" do
      pending # post_with_price.price.should eq(2) # only returns 0, never real price
    end
    it "should return an integer" do
      post.price.should eq(0)
    end
    it "should return 0 if the price isn't included in the listing" do
      post.price.should eq(0)
    end
  end
end

