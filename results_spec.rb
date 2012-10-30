require 'simplecov'
SimpleCov.start
require './results.rb'
require 'fakeweb'

describe Results do

  before(:each) do
    @page = File.read('yankees_search.html')
    FakeWeb.register_uri(:get, "http://sfbay.craigslist.org/search/sss?query=yankees&srchType=A&minAsk=0&maxAsk=1000000", :body => @page)
  end


  let(:results){ Results.new(Search.new("yankees").gen_html)}



  context "initialize" do
    it "should initialize html" do

      results.doc.should be_an_instance_of Nokogiri::HTML::Document
    end
  end
  
  context "#gen_hash" do 
    pending
  end

  context "#date" do 
    pending
  end
    
  context "#link" do 
    pending
  end
  
  context "#date" do 
    pending
  end

  context "#price" do 
    pending
  end




  context "links" do
    it "should return an array" do
      results.links.should be_an_instance_of Array
    end

    it "should contain html links in the array" do
      results.links.first[0..3].should == "http"
    end

    it "should return only posting links" do
      results.links.each do |link|
        link.should_not match /about/
        link.should_not match /search/
        link.should match /\d{10}/
      end
    end
  end

end
