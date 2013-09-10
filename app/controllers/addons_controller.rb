class AddonsController < ApplicationController
  before_action :set_addon, only: [:show, :edit, :update, :destroy]

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

  # GET /addons/1/edit
  def edit
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

  # PATCH/PUT /addons/1
  # PATCH/PUT /addons/1.json
  def update
    respond_to do |format|
      if @addon.update(addon_params)
        format.html { redirect_to @addon, notice: 'Addon was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @addon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addons/1
  # DELETE /addons/1.json
  def destroy
    @addon.destroy
    respond_to do |format|
      format.html { redirect_to addons_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_addon
      @addon = Addon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def addon_params
      params[:addon].permit(:name, :endpoint, :version)
    end
end