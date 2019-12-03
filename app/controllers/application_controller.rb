class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    redirect to "/recipes"
  end

  #load index form
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  #load new form
  get '/recipes/new' do
    erb :new
  end

  #create a recipe
  post '/recipes' do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect to "/recipes/#{@recipe.id}"
  end

  #load show
  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  #load edit form
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id]) 
    erb :edit
  end

  #update a recipe
  patch '/recipes/:id' do 
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  #destroy recipe
  delete '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect to "/recipes"
  end
  
end
