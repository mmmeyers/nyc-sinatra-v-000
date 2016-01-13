class LandmarksController < ApplicationController

  # {"landmark"=>{"name"=>"Arc de Triomphe", "year_completed"=>"1806"}}

  get '/landmarks' do 
    @landmarks = Landmark.all 
    erb :'/landmarks/landmarks'
  end

  get '/landmarks/new' do 
   @landmarks = Landmark.all
   @figures = Figure.all
   @titles = Title.all 
    erb :'/landmarks/new'
  end

  post '/landmarks' do 
    @landmark = Landmark.create(params[:landmark])
    @landmark.save
  end

  get '/landmarks/:id' do 
    @landmark = Landmark.find_by_id(params[:id])
    erb :'/landmarks/show'
  end

  get '/landmarks/:id/edit' do 
    @landmark = Landmark.find_by_id(params[:id])
    @titles = Title.all 
    @figures = Figure.all
    erb :'/landmarks/edit'
  end

  post '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params[:id])

      @landmark.name = params["landmark"]["name"]
      @landmark.year_completed = params["landmark"]["year_completed"]
      @landmark.save

    redirect "/landmarks/#{@landmark.id}"
  end

end

 # {"landmark"=>{"name"=>"Arc de Triomphe", "year_completed"=>"1806"}}
