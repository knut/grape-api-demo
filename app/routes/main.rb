class Main < Sinatra::Base

  set :public_folder, 'public'

  get "/" do
    File.read 'public/index.html'
  end
  
end