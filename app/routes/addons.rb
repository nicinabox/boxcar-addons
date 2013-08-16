require 'json'

namespace '/addons' do
  before { @title = 'All Addons' }

  # Index
  get '/?' do
    @addons = Addon.all
    respond_with :'addons/index' do |wants|
      wants.json { @addons.to_json }
      wants.html { erb 'addons/index'}
    end
  end

  # Create
  post '/?' do
    @addon  = Addon.new(params[:addon])
    version = params[:version]

    if @addon.save
      @addon.versions.create!(version)
      { :success => "Successfully registered #{@addon.name}" }.to_json
    else
      { :errors => @addon.errors.full_messages }.to_json
    end
  end

  get '/:name/?' do
    @addon = Addon.find_by_name(params[:name])
    respond_with :'addons/show' do |wants|
      wants.json { @addon.to_json }
      wants.html { erb 'addons/show'}
    end
  end

  # New
  # get '/new/?' do
  #   @title = 'New Addon'
  #   @addon = Addon.new

  #   erb 'addons/new'
  # end

  # Edit
  # get "/:id/edit/?" do
  #   @addon = Addon.find(params[:id])
  #   @title = "Edit Addon"

  #   erb 'addons/edit'
  # end

  # Update
  # put "/:id/?" do
  #   @addon = Addon.find(params[:id])
  #   if @addon.update_attributes(params[:addon])
  #     redirect "addons"
  #   else
  #     erb :"addons/edit"
  #   end
  # end

  # Delete
  # delete "/:id" do
  #   @addon = Addon.find(params[:id]).destroy
  #   redirect "addons"
  # end
end
