require './lib/database.rb'
require './lib/user.rb'

describe CraigsDatabase do
  # let(:test_database) { SQLite3::Database.open('./test_database.db') }
  let(:test_database) {CraigsDatabase.new}
  let(:user) { User.new("Hans Mustermann", 'hansiburli', 'foobar', 'hansy1@hotmail.com')}

  before :each do
    CraigsDatabase.stub(:connect).and_return(test_database)
  end

  it "should save stuff" do
    CraigsDatabase.to_database('users', user)
    row = CraigsDatabase.execute("select * from users")
    row.should include('Hans Mustermann')
  end

  after :each do
    # test_database.execute("delete from users")
    # test_database.execute("delete from searches")
    # test_database.execute("delete from posts")
  end
end