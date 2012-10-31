require 'sqlite3'


db = SQLite3::Database.open('craigs_list.db')
# users = db.execute('CREATE TABLE IF NOT EXISTS users (id integer primary key autoincrement, name varchar(64), password varchar(64), username varchar(64), email varchar(64), created_at default current_timestamp);')
# db.execute('INSERT (name, password, username, email) INTO users ("");')
#
# searches = db.execute('CREATE TABLE IF NOT EXISTS searches (id integer primary key autoincrement, search_url varchar(255), category varchar(64), region varchar(64), max_price integer, keyword varchar(64), created_at default current_timestamp, user_id integer, foreign key(user_id) references users(id));')
#
# posts = db.execute('CREATE TABLE IF NOT EXISTS posts (id integer primary key autoincrement, search_id integer, posted_at datetime, title varchar(128), price varchar(16), neighborhood varchar(64), post_url varchar(255), category varchar(64), foreign key(search_id) references searches(id));')

db.execute("SELECT * FROM searches;"){|row| puts row}



