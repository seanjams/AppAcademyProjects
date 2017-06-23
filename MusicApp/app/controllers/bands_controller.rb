class BandsController < ApplicationController
  def create
    @band = Band.create(band_params)
    if @band.save?
      redirect_to band_url(@band)
    else
      flash[:errors] = ["Band not in database"]
      redirect_to bands_url
    end
  end

  def new
    @band = Band.new
    render :new
  end

  def index
    @bands = Band.all
    render :index
  end

  def show
    @band = Band.find_by(id: params[:id])
    if @band.nil?
      flash[:errors] = ["Band not in database"]
      redirect_to bands_url
    else
      render :show
    end
  end

  def update
    @band = Band.find_by(id: params[:id])
    if @band.update_attributes(band_params).nil?
      flash[:errors] = ["Band not in database"]
      redirect_to bands_url
    else
      redirect_to band_url(@band)
    end
  end

  def edit
    @band = Band.find_by(id: params[:id])
    render :edit
  end

  def destroy
    Band.delete(params[:id])
    redirect_to bands_url
  end

  private

  def band_params
    params[:band].require(:name)
  end
end
