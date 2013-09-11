class AddonsController < ApplicationController
  before_action :set_addon, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]

  # GET /addons
  # GET /addons.json
  def index
    @addons = Addon.all
  end

  # GET /addons/1
  # GET /addons/1.json
  def show
  end

  # GET /addons/new
  def new
    @addon = Addon.new
  end

  # POST /addons
  # POST /addons.json
  def create
    @addon = Addon.new(addon_params)

    @addon.clone_repo

    boxcar_json = @addon.parse_boxcar_json
    boxcar_json.reject! { |k, v|
      Version.attribute_names.exclude?(k) and
      Version.attribute_aliases.exclude?(k)
    }

    @addon.versions.build boxcar_json
    @addon.user = current_user

    respond_to do |format|
      if @addon.save
        format.html { redirect_to @addon, notice: 'Addon was successfully created.' }
        format.json { render action: 'show', status: :created, location: @addon }
      else
        format.html { render action: 'new' }
        format.json { render json: @addon.errors, status: :unprocessable_entity }
      end
    end
  end

  def my_addons
    @addons = current_user.addons
    render :by_author
  end

  def by_author
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_addon
      @addon = Addon.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def addon_params
      params[:addon].permit(:name, :endpoint, :version)
    end
end
