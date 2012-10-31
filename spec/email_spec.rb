require 'simplecov'
SimpleCov.start

require './lib/email.rb'


describe Email do
  let(:email) { Email.new(0) }

  context "initialize" do
    it "should have a sender" do
      email.sender.should eq("scrape.of.duty@gmail.com")
    end

    it "should have a password" do
      email.password.should eq("scrapeofduty")
    end

    it "should have a date" do
      email.stub(:date).and_return(DateTime.now)
      email.date.should eq(DateTime.now)
    end

    it "should have a keyword" do
      email.keyword.should eq("kittens")
    end

    it "should have a search_url" do
      email.stub(:search_url).and_return('some url')
    end

    it "should have a user" do
      email.stub(:user).and_return('some user')
    end

    it "should have a recipient" do
      email.stub(:recipient).and_return('recipient email address')
    end

    it "should have a body" do
      email.stub(:body).and_return('database items')
    end
  end

  # context "to_s" do
  #   it "should format information as a string" do
  #     email.to_s.to be_an_instance_of(String)
  #   end
  # end

  context "send" do
    let(:mail) { Mail.new }
    it "should have an smtp hash" do
      email.stub(:send).should be_an_instance_of(Hash)
    end

    # it "should instantiate a Mail object" do
    #   email.stub(:send).should respond_to(:mail)
    # end
    # 
    # it "should deliver mail" do
    #   email.stub(:send).should respond_to(deliver!)
    # end
  end
end


