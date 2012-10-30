require 'simplecov'
SimpleCov.start
require_relative 'user.rb'

describe User do
  let(:user) { User.new("Daniela Grossmann", "dgrossmann", "iloveruby", "dg@dg.com") }
  let(:user_false) {User.new("Daniela Grossmann", "dgrossmann", "iloveruby", "123@dani.comrrhdf")}
  # let(:db) {SQLite3::Database.new('craigs_list.db')}
  context '#initialize' do
    it "should have a full name" do
      user.full_name.should eq "Daniela Grossmann"
    end

    it "should have a username" do
      user.username.should eq "dgrossmann"
    end

    it "should have a password" do
      user.password.should eq "iloveruby"
    end

    it "should have an email address" do
      user.email.should eq "dg@dg.com"
    end
  end
  context '#valid_email?' do
    it "should have a valid email address" do
      user.email.should match /([a-zA-Z]+)@([a-zA-Z]+)\.([a-zA-Z]{2,4})/
    end
    it "should raise an error for a false email address" do
      user_false.email.should raise_error
    end
  end

  context "#to_database" do
    # it "should write user information to the database" do
    #
    #      expect { user.db }.to change { db.size }.by(1)
    #    end
  end

end