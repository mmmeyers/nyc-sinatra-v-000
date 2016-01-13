class FiguresController < ApplicationController

  # to create new figure in tux: Figure.create(:name => "name")
  # to delete in tux: Figure.delete(id#)
  # to find a figure: Figure.find(1) - will give you figure who has id of 1 ("Billy The Kid")
  # to find a figure's name: Figure.find(1).name - will give you "Billy the Kid"
  # to update a figure's name: Figure.update(1, :name => "new name")

  # {
  #   "figure"=>   LEVEL 1
  #     {"name"=>"Doctor Who"}, LEVEL 2 [:figure][:name]
  #   "title"=>    LEVEL 1
  #     {"name"=>"Time Lord"},  LEVEL 2 [:title][:name]
  #   "landmark"=> LEVEL 1
  #     {"name"=>""}            LEVEL 2 [:landmark][:name]
  # }

  get '/figures' do
    @figures = Figure.all
    erb :'figures/figures'
  end

  get '/figures/new' do 
     @landmarks = Landmark.all
     @titles = Title.all 
    erb :'/figures/new'
  end

  post '/figures' do 
    @figure = Figure.create(params[:figure])

    if !params[:title][:name].empty?
      @new_title = Title.create(:name => params[:title][:name])
      @figure.titles << @new_title
    end

    if !params[:landmark][:name].empty?
      @new_landmark = Landmark.create(:name => params[:landmark][:name])
      @figure.landmarks << @new_landmark
    end

  end

  get '/figures/:id' do 
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do 
    @figure = Figure.find_by_id(params[:id])
    @titles = Title.all 
    @landmarks = Landmark.all
    erb :'/figures/edit'
  end

  post '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])

    if !params[:figure][:name].empty?
      @figure.name = params[:figure][:name]
    end

    if !params[:title][:name].empty?
      @new_title = Title.create(:name => params[:title][:name])
      @figure.titles << @new_title
      @figure.save
    end

    if !params[:landmark][:name].empty?
      @new_landmark = Landmark.create(:name => params[:landmark][:name])
      @figure.landmarks << @new_landmark
      @figure.save
    end
    redirect "/figures/#{@figure.id}"
  end

end
