module DB
  require('pg')

  def get_all_posts
    conn.exec("SELECT id, username, title, body FROM posts WHERE username = $1", [params[:username]]).to_a
  end

  def get_one_post
    id, username = params.values_at(:id, :username)
    conn.exec("SELECT id, username, title, body FROM posts WHERE username = $1 AND id = $2", [username, id]).to_a
  end

  def create_post
    title, body, username = params.values_at(:title, :body, :username)
    conn.exec("INSERT INTO posts (title, body, username) VALUES ($1, $2, $3) RETURNING id", [title, body, username]).to_a
  end

  def update_post
    id, title, body, username = params.values_at(:id, :title, :body, :username)
    conn.exec("UPDATE posts SET title = $1, body = $2 WHERE username = $3 AND id = $4 RETURNING id", [title, body, username, id]).to_a
  end

  def delete_post
    username, id = params.values_at(:username, :id)
    post = conn.exec("DELETE FROM posts WHERE username = $1 AND id = $2", [username, id]).to_a
  end

  private

  def conn
    if ENV["RACK_ENV"] == 'production'
      @@conn ||= PG.connect(
        dbname: ENV["POSTGRES_DB"],
        host: ENV["POSTGRES_HOST"],
        password: ENV["POSTGRES_PASS"],
        user: ENV["POSTGRES_USER"]
      )
    else
      @@conn ||= PG.connect(dbname: "blog_api_db")
    end
  end
end # module DB
