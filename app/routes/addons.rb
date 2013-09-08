require 'json'

namespace '/addons' do
  before { @title = 'All Addons' }

  # Index
  get '/?' do
    @addons = Addon.all
    erb 'addons/index'
  end

  get '.json' do
    addons = Addon.all
    addons.to_json(:include => :latest_version)
  end

  # Create
  post '/?' do
    @addon  = Addon.new(params[:addon])

    @addon.clone_repo
    metadata = @addon.parse_boxcar_json.select!{ |a|
      Version.attribute_names.index(a)
    }

    if @addon.save
      @addon.versions.create!(metadata)

      respond_with :'addons/show' do |wants|
        wants.json {
          { :success => "Successfully registered #{@addon.name}" }.to_json
        }
        wants.html { erb 'addons/show'}
      end

    else
      respond_with :'addons/new' do |wants|
        wants.json {
          { :errors => @addon.errors.full_messages }.to_json
        }
        wants.html { erb 'addons/new'}
      end
    end

  end

  get '/new/?' do
    @addon = Addon.new
    erb 'addons/new'
  end

  get '/:name/?' do
    @addon = Addon.find_by_name(params[:name])
    respond_with :'addons/show' do |wants|
      wants.json { @addon.to_json }
      wants.html { erb 'addons/show'}
    end
  end
end
