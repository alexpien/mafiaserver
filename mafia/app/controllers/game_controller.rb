class GameController < ApplicationController
  
  def join
    @@g ||= Game.new
    me=@@g.add_player(params[:name])
    render :json=> {:id=>me.id,:name=>me.name}
  end

  def start_game
    if not @@g.mafia
      @@g.start
    end
    render :nothing=>true
  end

  def reset
    @@g=nil
    render :nothing=>true
  end
  
  def get_players
    render :json=>@@g.players
  end

  def vote(voter,kill)
    @@g.vote(voter,kill)
  end
 
  def begin_next_round
    @@g.begin_next_round
  end


  def vote_results
    @@g.get_votes
  end

  def has_game_started
    id=params[:id]
    puts @@g.mafia
    if @@g.mafia
      if id.to_i==@@g.mafia
        render :json=>{:result=>"mafia"}
      else
        render :json=>{:result=>"peasant"}
      end
    else
      render :json=>{:result=>"waiting"}
    end
  end
end
