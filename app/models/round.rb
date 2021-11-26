class Round < ApplicationRecord
    has_many :bets
    belongs_to :roulette

    def notify
        bets.each {|bet| bet.notify_player(self)}
    end

    def update_color(color)
        update(color: color)
    end

end
