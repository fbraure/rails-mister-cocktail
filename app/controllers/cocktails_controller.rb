class CocktailsController < ApplicationController
  before_action :get_instance_from_id, only: [:show, :edit, :update, :destroy]

  def index
    @cocktails = Cocktail.all
  end

  def show
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(required_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @cocktail.photos.attach(params[:cocktail][:photos])
    # TODO: Ajout de test d"upload et redirection
    if @cocktail.update(required_params_update)
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @cocktail.destroy
    redirect_to cocktails_path
  end

  private

  def get_instance_from_id
    @cocktail = Cocktail.find(params[:id])
  end

  def required_params
    params.require(:cocktail).permit(:name, :image, photos: [])
  end
  def required_params_update
    params.require(:cocktail).permit(:name, :image)
  end
end
