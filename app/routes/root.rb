namespace '/' do
  before { @title = 'Boxcar Addons' }
  get do
    redirect 'addons'
  end
end
