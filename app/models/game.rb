class Game
  
  attr_accessor :players, :votes, :mafia, :dead_players, :player_hash
  
  def initialize
    self.players=[]
    self.mafia=nil
    self.dead_players=[]
    self.votes={}
    self.player_hash={}
  end

  def add_player(n)
    p = Player.new
    p.name=n
    p.id=self.players.length+1
    self.players << p
    self.player_hash[self.players.length]=n
    return p
  end

  def kill_player(id)
    if id!=-1
      self.players.delete(id)
      self.dead_players.add(id)
    end
  end
  

  def start
    self.mafia=1+rand(self.players.length)
    self.begin_next_round
  end

  def begin_next_round
    self.votes={}
    @end_time=Time.now.to_i+30
  end
  
  def end_round
    tally={}
    for vote in votes.keys do
      tally[votes[vote]]||=0
      tally[votes[vote]]+=1
    end
    max=0
    maxplayer=-1
    for id in tally.keys
      if tally[id]>max
        max=tally[id]
        maxplayer=id
      elsif tally[id]==max
        maxplayer=-1
      end

    end
    self.kill_player(maxplayer)
  end

  
  def vote(voter,kill)
    self.votes[voter]=kill
  end

  def get_votes
    hash={}
    hash["votes"]=self.votes
    hash["finished"]=false
    if Time.now.to_i > @end_time
      hash["finished"]=true
      self.end_round
    end
    
    hash

  end


  
end
