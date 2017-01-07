class ApiBlog < Sinatra::Base
  namespace "/api" do
    get "/posts/:username" do
      get_all_posts.to_json
    end

    get "/posts/:id/:username" do 
      get_one_post.to_json
    end
  end
end
    
