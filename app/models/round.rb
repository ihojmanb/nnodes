class Round < ApplicationRecord
    has_many :bets

    def notify
        bets.each {|bet| bet.notify_player(self)}
    end


end
