require 'sinatra'
require 'shotgun'


get '/' do
  @board = 'Leader Board'
  @league = 'NFL'
  erb :index
end

get '/leaderboard' do
  @scores = [
  {
    home_team: "Patriots",
    away_team: "Broncos",
    home_score: 7,
    away_score: 3
  },
  {
    home_team: "Broncos",
    away_team: "Colts",
    home_score: 3,
    away_score: 0
  },
  {
    home_team: "Patriots",
    away_team: "Colts",
    home_score: 11,
    away_score: 7
  },
  {
    home_team: "Steelers",
    away_team: "Patriots",
    home_score: 7,
    away_score: 21
  }
]
  @leaderboard = Hash.new{|h,k| h[k]=Hash.new(0)}
@scores.each do |game|
  if game[:home_score].to_i > game[:away_score].to_i
    @leaderboard[game[:home_team]][:w] += 1
    @leaderboard[game[:away_team]][:l] += 1
  else
    @leaderboard[game[:away_team]][:w] += 1
    @leaderboard[game[:home_team]][:l] += 1
  end
end

@leaderboard = @leaderboard.sort_by{ |team_name, record| [-record[:w],record[:l]]}


  @board = 'Leader Board'
  erb :leaderboard
end
