class ApiBlog < Sinatra::Base
  get "/" do 
    erb :home
  end

  get "/docs" do 
    erb :docs
  end
end
