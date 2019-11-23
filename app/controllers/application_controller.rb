class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/recipes'
  end
  
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end
  
  get '/recipes/new' do
    erb :"recipes/new"
    # Why is there a question mark in the URL??
  end
  
  post '/recipes' do
    @recipe = Recipe.new(
      name: params[:name],
      ingredients: params[:ingredients],
      cook_time: params[:cook_time]
    )
    @recipe.save
    params[:id] = @recipe.id

    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe
      erb :"recipes/show"
    else
      redirect :"/recipes"
    end
  end

  delete '/recipes/:id' do
    Recipe.destroy(params[:id])
    
    redirect :"/recipes"
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :"recipes/edit"
  end

  patch '/recipes/:id' do
    recipe = Recipe.find_by_id(params[:id])
    recipe.update_attributes(
      name: params[:name],
      ingredients: params[:ingredients],
      cook_time: params[:cook_time]
    )
    redirect "/recipes/#{@recipe.id}"
  end
end
