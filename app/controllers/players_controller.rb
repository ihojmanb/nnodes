class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:id])
    # debugger
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(create_player_params)
    if @player.save
      flash[:success] = "Nuevo jugador creado exitosamente"
      redirect_to @player
    else
      render 'new'
    end
  end

  def edit 
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    if @player.update(update_player_params)
      flash[:success] = "Jugador editado exitosamente"
      redirect_to @player
    else
      render 'edit'
    end 
  end

  def index
  end

  private
    def create_player_params
      params.require(:player).permit(:first_name, :last_name, :email)
    end

    def update_player_params
      params.require(:player).permit(:first_name, :last_name, :email, :balance)
    end

end
