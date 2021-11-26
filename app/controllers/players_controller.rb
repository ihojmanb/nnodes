class PlayersController < ApplicationController
  def index
    @players = Player.paginate(page: params[:page], per_page: 10)
  end

  def show
    @player = Player.find(params[:id])
    @bets = @player.bets.paginate(page: params[:page], per_page: 10)
    # debugger
  end

  def new
    @player = Player.new
  end

  def create
    @roulette = Roulette.first
    @player = Player.new(create_player_params)
    @player.roulette_id = @roulette.id
    if @player.save
      flash[:success] = "Nuevo jugador creado exitosamente"
      redirect_to @player
    else
      render "new"
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
      render "edit"
    end
  end

  private

  def create_player_params
    params.require(:player).permit(:first_name, :last_name, :email)
  end

  def update_player_params
    params.require(:player).permit(:first_name, :last_name, :email, :balance)
  end
end
