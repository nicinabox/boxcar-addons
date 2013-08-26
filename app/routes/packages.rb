require 'json'

namespace '/packages' do
  get '/:name' do
    @package = Package.find_all_by_name(params[:name])
    @package.to_json(:methods => :path)
  end

  get '/:name/:version' do
    @package = Package.where(:name => params[:name],
                             :version => params[:version])

    @package.to_json(:methods => :path)
  end
end
