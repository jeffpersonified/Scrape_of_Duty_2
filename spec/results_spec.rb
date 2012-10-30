require 'simplecov'
SimpleCov.start

require './lib/results.rb'
require './lib/post.rb'
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

  context "#posts" do
    it "should be an instance of Array" do
      results.posts.should be_an_instance_of Array
    end

    it "should be composed of elements of the Post class" do
      results.posts.each { |post| post.should be_instance_of Post }
    end
  end

  # context "links" do
  #   it "should return an array" do
  #     results.links.should be_an_instance_of Array
  #   end
  #
  #   it "should contain html links in the array" do
  #     results.links.first[0..3].should == "http"
  #   end
  #
  #   it "should return only posting links" do
  #     results.links.each do |link|
  #       link.should_not match /about/
  #       link.should_not match /search/
  #       link.should match /\d{10}/
  #     end
  #   end
  # end

end
