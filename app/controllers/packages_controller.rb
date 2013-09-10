class PackagesController < ApplicationController
  before_action :set_package, only: [:show]

  def index
    @packages = Package.all
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_package
      @package = Package.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def package_params
      params[:package].permit(:name, :version, :arch, :build, :package_name,
                              :location, :size_uncompressed, :size_compressed,
                              :slackware_version)
    end
end
