class RoundsController < ApplicationController
    def index
        @rounds = Round.paginate(page: params[:page], per_page: 10)
        @players = Player.paginate(page: params[:page], per_page: 10)
        @bets = Bet.paginate(page: params[:page], per_page: 10)
      end
end
