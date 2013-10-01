class PackagesController < ApplicationController
  before_filter :set_format
  respond_to :json

  def index
    @packages = Package.all
  end

  def show
    @packages = Package.find_all_by_name(params[:id])
    render :index
  end

  def search
    @packages = Package.where('name like ?' , "%#{params[:q]}%")
  end

  def version
    @package = Package.where(name:    params[:id],
                             version: params[:version]
                             ).first
  end

  private
    def set_format
      request.format = 'json'
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def package_params
      params[:package].permit(:name, :version, :arch, :build, :package_name,
                              :location, :size_uncompressed, :size_compressed,
                              :slackware_version)
    end
end
