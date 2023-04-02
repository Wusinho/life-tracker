class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :house
  has_many :games_created, through: :house, source: :games
  has_many :players
  has_many :user_kills
  validate :active_game?
  has_many :kills, through: :user_kills, source: :deceased
  has_many :games_played, through: :players, source: :game

  scope :order_wins, -> { order(win_rate: :asc) }
  scope :online_players, -> { where(online: true) }

  # def death_players
  #   kills.tally.map { |user, count| { nickname: user.nickname, kills: count } }
  #         .sort_by { |h| -h[:kills] }
  #         .take(2)
  # end
  def self.with_games
    User.left_outer_joins(:players => :game).where("games.id IS NOT NULL").order('win_rate DESC').distinct
  end

  def win_rate_stats
    wr = win_rate
    return unless wr

    hash = { win: wr, lost: (1-wr).round(2) }
    hash.stringify_keys
  end

  def win_rate_formula
    total_games_player = games_played.length
    return nil if total_games_player.zero?

    wins/total_games_player.to_f
  end

  def update_win_rate
    self.update(win_rate: win_rate_formula&.round(2) )
  end

  def average_player_damage
    players.average(:damage_done).to_f.round(2)
  end

  def total_kills
    kills.length
  end

  def death_players
    kills.group(:nickname).count.sort_by { |h| -h[1] }
  end

  def total_games_played
    games_played.length
  end

  def display_polar
    death_players.to_h
  end


  def active_game?
    games_created.where(ended: false).count == 0
  end

  def find_last_player_updated
    self.players.order(updated_at: :asc).first
  end

  def kills_per_game
  hash = {}
    all_games_played = self.games_played.pluck(:id, :created_at)
    kills = user_kills.group(:game_id).count
    all_games_played.each do |info|
      kills[info.first] ? hash[info.last] = kills[info.first] : hash[info.last] = 0
    end

  hash.stringify_keys
  end

  def average_kills
    kills = user_kills.group(:game_id).count
    arr_kills = kills.values.reduce(&:+)

    (arr_kills/kills.length.to_f).round(2)
  end

  def average_kill_per_game

    total_kills = kills_per_game.map { |k,v| v}
    return if total_kills.blank?

    (total_kills.sum(0.0)/total_kills.size).round(2)
  end

  def average_damage_per_game
    self.players.average(:damage_done).to_f.round(2)
  end

  def games?
    self.games_played.present?
  end

  def game
    games_created.find_by(ended: false)
  end

  def player
    self.players.find_by(active: true)
  end

  def has_house?
    self.house.present?
  end

  def game_owner?(game)
    return unless has_house?

    self.house.games.where(id: game.id).present?
  end



  def user_killed_most
    return [] if user_kills.empty?

    users = self.user_kills.map { |players| players.deceased }
    user_counts = users.tally

    user_counts.map { |user, count| { nickname: user.nickname, kills: count } }
               .sort_by { |h| -h[:kills] }
  end

end
