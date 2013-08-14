namespace '/' do
  before { @title = 'Boxcar Addons' }
  get do
    erb 'index'
  end
end
