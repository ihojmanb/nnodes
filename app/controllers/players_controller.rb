class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:id])
    # debugger
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(user_params)
    if @player.save
      flash[:success] = "Nuevo jugador creado exitosamente"
      redirect_to @player
    else
      render 'new'
    end
  end

  def index
  end

  private
    def user_params
      params.require(:player).permit(:first_name, :last_name, :email)
    end


end
