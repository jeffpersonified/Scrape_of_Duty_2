require 'sqlite3'

class CraigsDatabase
  attr_reader :db_name

    DB_NAME = './craigs_list.db'
  # def initialize
  #    @db_name = 'craigs_list.db'
  #  end

  def self.to_database(table, object, foreign_key_id = nil)
    case table
    when 'users'
      insert_string = "INSERT INTO #{table} (name, password, username, email)
                      VALUES ('#{object.name}', '#{object.password}', '#{object.username}', '#{object.email}');"

    when 'posts'
      insert_string = "INSERT INTO #{table} (search_id, posted_at, title, price, neighborhood, post_url, content)
                      VALUES ('#{foreign_key_id}', '#{object.posted_at}', '#{object.title}', '#{object.price}',
                      '#{object.neighborhood}', '#{object.post_url}', '#{object.content}');"
    when 'searches'
      insert_string = "INSERT INTO #{table} (search_url, category, region, min_price, max_price, keyword, user_id)
                      VALUES ('#{object.search_url}', '#{object.category}', '#{object.region}',
                      '#{object.min_price}', '#{object.max_price}', '#{object.keyword}', '#{foreign_key_id}');" # TODO: foreign key
    end
    db_handler(insert_string)
  end

  def self.from_database(table)
    reader_string = "SELECT * FROM #{table};"
    db_handler(reader_string)
  end

  def self.get_items(table, *items)
    finder_string = "SELECT "
    (items.length - 1).times do |i|
      finder_string += "#{items[i]}, "
    end
    finder_string += "#{items[-1]} FROM #{table};"
    db_handler(finder_string)
  end

  def self.db_handler(string)
    db = SQLite3::Database.open(DB_NAME)
    result = db.execute(string)
    db.close
    result
  end

end

# my_db = CraigsDatabase.new
# dani = User.new("Jeff Smith", "jeffsmith", "foobar", "jeff_m@smith.com")
# my_db.to_database('users', dani)
# p my_db.from_database('users')
# p my_db.get_items('users', 'email', 'name')

