MovieGrabber2::App.controllers :movies do
  
  layout "movies"

  get :search do
    erb :'movies/search'
  end

  get :index do 
    @movies = Movie.search(params[:query])
      erb :'movies/index'
  end
end