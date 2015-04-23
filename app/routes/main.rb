class Main < Sinatra::Base

  set :public_folder, 'public'

  get "/" do
    redirect '/index.html'
  end
  
end