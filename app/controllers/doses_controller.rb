class DosesController < ApplicationController
  before_action :get_instance_from_id, only: [:destroy]

  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new(required_params)
    @dose.cocktail = @cocktail

    @ingredient = Ingredient.find(params[:dose][:ingredient_id])
    byebug
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    redirect_to cocktail_path(@dose.cocktail)
    @dose.destroy
  end

  private

  def get_instance_from_id
    @dose = Dose.find(params[:id])
  end

  def required_params
    params.require(:dose).permit(:description, :ingredient_id)
    # params.require(:dose).permit(:description, :ingredient_id)
  end
end
