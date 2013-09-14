class GameController < ApplicationController
  
  def join
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
    @@g=Game.new
    render :nothing=>true
  end
  
  def get_players
    render :json=>@@g.players
  end

  def get_player_hash
    render :json=>@@g.player_hash
  end
  def vote
    @@g.vote(params[:voter],params[:kill])
    render :nothing=>true
  end
 
  def begin_next_round
    @@g.begin_next_round
    render :nothing=>true
  end
  
  def mafia_kill
    @@g.kill_player(params[:id])
  end


  def vote_results

    render :json=>@@g.get_votes
    
  end
  
  def get_dead_players
    render :json=>@@g.dead_players
  end
  
  def has_game_started
    id=params[:id].to_i
    if @@g.mafia
      if id==@@g.mafia
        render :json=>{:result=>"mafia"}
      else
        render :json=>{:result=>"peasant"}
      end
    else
      render :json=>{:result=>"waiting"}
    end
  end

  
  
end
