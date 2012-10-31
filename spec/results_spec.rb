require 'simplecov'
SimpleCov.start

require './lib/results.rb'
require 'fakeweb'

describe Results do

  before(:each) do
    @url = "http://sfbay.craigslist.org/search/sss?query=yankees&srchType=A&minAsk=0&maxAsk=1000000"
    @page = File.read('yankees_search.html')
    FakeWeb.register_uri(:get, @url, :body => @page)
  end


  let(:results){ Results.new(Search.new("yankees").gen_html, @url)}

  context "initialize" do
    it "should initialize a Results object" do
      results.should be_an_instance_of Results
    end

    it "should take an HTML document as its first argument" do
      results.doc.should be_an_instance_of Nokogiri::HTML::Document
    end

    it "should take a URL address as its second argument" do
      results.search_url.should match /http:/
    end
  end

  context "#post_attributes" do
    it "should be an instance of array" do
      results.post_attributes.should be_instance_of Array
    end
    it "each set of attributes should contain 6 elements" do
      results.post_attributes.each do |set|
        set.length.should eq(6)
      end
    end
  end

  context "#posts" do
    it "should be an instance of Array" do
      results.posts.should be_an_instance_of Array
    end

    it "should be composed of elements of the Post class" do
      results.posts.each { |post| post.should be_instance_of Post }
    end
  end
end
