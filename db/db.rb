module DB
  require('pg')

  def get_all_posts
    conn.exec("SELECT * FROM posts WHERE username = $1", [params[:username]]).to_a
  end

  def get_one_post
    id, username = params.values_at(:id, :username)
    conn.exec("SELECT * FROM posts WHERE username = $1 AND id = $2", [username, id]).to_a
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
end
