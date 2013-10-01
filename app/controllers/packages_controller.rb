class PackagesController < ApplicationController
  respond_to :json

  def index
    @packages = Package.all
  end

  def show
    @packages = Package.find_all_by_name(params[:id])
    render json: @packages.to_json
  end

  def version
    @package = Package.where(name:    params[:id],
                             version: params[:version]
                             ).first

    if @package
      render json: @package.to_json
    else
      render json: '404', status: 404
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def package_params
      params[:package].permit(:name, :version, :arch, :build, :package_name,
                              :location, :size_uncompressed, :size_compressed,
                              :slackware_version)
    end
end
