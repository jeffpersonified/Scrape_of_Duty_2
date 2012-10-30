require 'simplecov'
SimpleCov.start

require './results.rb'
require 'fakeweb'

describe Search do
  let(:search){ Search.new("yankees") }

  before(:each) do
    @page = File.read('yankees_search.html')
    FakeWeb.register_uri(:get, "http://sfbay.craigslist.org/search/sss?query=yankees&srchType=A&minAsk=0&maxAsk=1000000", :body => @page)
  end

  context "initialize" do
    it "initializes a search object" do
      search.should be_instance_of Search
    end

    it "creates all instance variables" do
      search.should respond_to :region
      search.should respond_to :search_terms
      search.should respond_to :max_price
      search.should respond_to :min_price
    end
  end

  context "#gen_html" do
    it "should generate html" do
      search.gen_html.should be_an_instance_of Nokogiri::HTML::Document
    end
  end

  context "#results" do
    it "should return a new instance of Results" do
      search.results.should be_an_instance_of Results
    end
  end
end
