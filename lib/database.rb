require 'sqlite3'

class CraigsDatabase
  attr_accessor :db_name, :to_database

    DB_NAME = './craigs_list.db'
  # def initialize(db_name = DB_NAME)
  #      @db_name = db_name
  #    end

  def self.to_database(object)
    case object.class
    when User
      insert_string = "INSERT INTO users (name, password, username, email)
                      VALUES ('#{object.name}', '#{object.password}', '#{object.username}', '#{object.email}');"
    when Post
      insert_string = "INSERT INTO posts (search_id, posted_at, title, price, neighborhood, post_url, category)
                      VALUES ('#{return_id(object.search_url, 1)}', '#{object.posted_at}', '#{object.title}', '#{object.price}',
                      '#{object.neighborhood}', '#{object.post_url}', '#{object.category}');"
    when Search
      insert_string = "INSERT INTO searches (search_url, category, region, min_price, max_price, keyword, user_id)
                      VALUES ('#{object.search_url}', '#{object.category}', '#{object.region}',
                      '#{object.min_price}', '#{object.max_price}', '#{object.keyword}', '#{return_id(object.username, 0)}');"
    end
    db_handler(insert_string)
  end

  def self.from_database(table)
    # returns nested arrays
    reader_string = "SELECT * FROM #{table};"
    db_handler(reader_string)
  end

  def self.get_items(table, *items)
    # returns nested arrays
    finder_string = "SELECT "
    (items.length - 1).times do |i|
      finder_string += "#{items[i]}, "
    end
    finder_string += "#{items[-1]} FROM #{table};"
    db_handler(finder_string)
  end

  def self.get_posts(date, *items)
    finder_string "SELECT "
    (items.length - 1).times do |i|
      finder_string += "p.#{items[i]}, "
    end
    finder_string += "p.#{items[-1]} FROM posts p WHERE posted_at like '#{date}%';"
    db_handler(finder_string)
  end

  def self.return_id(search_param, case_no)
    case case_no
    when 0
      finder_string = "SELECT id FROM users WHERE username = #{search_param};"
    when 1
      finder_string = "SELECT id FROM searches WHERE url = #{search_param};"
    end
    db_handler(finder_string)
  end

def self.find_item(search_word, search_class, table)
    finder_string = "SEARCH * FROM #{table} WHERE #{search_class} = #{search_word};"
    db_handler(finder_string)
  end

  def self.delete_content_from_table(table)
    delete_string = "DELETE FROM #{table};"
    db_handler(delete_string)
  end

  def self.delete_row_with_id(table, id)
    delete_string = "DELETE FROM #{table} WHERE id = #{id};"
    db_handler(delete_string)
  end

  def self.db_handler(string)
    db = SQLite3::Database.open(DB_NAME)
    result = db.execute(string)
    db.close
    result
  end

  # def self.connection
  #    @connection ||= SQLite3::Database.open(@db_name)
  #  end

end

# my_db = CraigsDatabase.new
# dani = User.new("Jeff Smith", "jeffsmith", "foobar", "jeff_m@smith.com")
# my_db.to_database('users', dani)
# p my_db.from_database('users')
# p my_db.get_items('users', 'email', 'name')

