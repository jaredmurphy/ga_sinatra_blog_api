require 'pg'


if ENV["RACK_ENV"] == 'production'
  conn = PG.connect(
  dbname: ENV["POSTGRES_DB"],
  host: ENV["POSTGRES_HOST"],
  password: ENV["POSTGRES_PASS"],
  user: ENV["POSTGRES_USER"]
  )
else
  conn = PG.connect(dbname: "blog_api_db")
end

conn.exec("DROP TABLE IF EXISTS posts")
conn.exec("CREATE TABLE posts(
  id SERIAL PRIMARY KEY,
  title VARCHAR(50),
  body VARCHAR,
  username VARCHAR,
  created_at timestamp DEFAULT current_timestamp
)")

conn.exec("INSERT INTO posts (title, body, username) VALUES ('The Question Concerning Technology', 'Technology is therefore no mere means. Technology is a way of revealing. If we give heed to this, then another whole realm for the essence of technology will open itself up to us. It is the realm of revealing, i.e., of truth.', 'Martin Heidegger')")

conn.exec("INSERT INTO posts (title, body, username) VALUES ('Twilight of the Idols', 'I mistrust all systematizers and avoid them. the will to a system is a lack of integrity.', 'Friedrich Nietzsche')")

conn.exec("INSERT INTO posts (title, body, username) VALUES ('Critique of Pure Reason', 'All human cognition begins with intuitions, proceeds from thence to conceptions, and ends with ideas.', 'Immanuel Kant')")


posts_counts = conn.exec("SELECT * FROM posts").count
puts "#{posts_counts} posts created"

