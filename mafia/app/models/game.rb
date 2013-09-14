class Game
  
  attr_accessor :num_players, :players, :votes, :mafia
  
  def initialize
    self.num_players=0
    self.players=[]
    self.mafia=nil
  end

  def add_player(n)
    p = Player.new
    p.name=n
    self.num_players+=1
    p.id=self.num_players
    self.players << p

    return p
  end

  def kill_player(id)
    self.num_players-=1
    players.delete(id)
  end
  

  def start
    self.mafia=1+rand(self.num_players)
    self.begin_next_round
  end

  def begin_next_round
    @voted=0
    self.votes={}
    @end_time=Time.now.to_i+30
  end
  
  def end_round
    tally={}
    for vote in votes do
      tally[votes[vote]]+=1
    end
    max=0
    for id in tally
      if tally[id]>max
        max=tally
      end

    end
  end

  
  def vote(voter,kill)
    self.votes[voter]=kill
  end

  def get_votes
    if Time.now.to_i>@end_time
      self.end_round
    else
      self.votes
    end

  end


  
end
