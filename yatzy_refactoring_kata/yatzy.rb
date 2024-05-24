class Yatzy
  def initialize(*dice)
    @dice = *dice
    @tally = @dice.tally
  end

  def yatzy
    return 50 if @tally.value? 5

    0
  end

  def single(number)
    count = @tally[number] || 0
    count * number
  end

  def n_of_a_kind(number)
    dice = @tally.select { |_dice, count| count >= number }.max&.first || 0

    dice * number
  end

  def pairs
    @tally.select { |_dice, count| count >= 2 }
  end

  def two_pair
    # multiply both pairs by their values and return the sum
    pairs.map { |dice, _count| dice * 2 }.sum
  end

  def full_house
    return @dice.sum if @tally.value?(3) && @tally.value?(2)

    0
  end

  def self.chance(*dice)
    dice.sum
  end

  # TODO: .yatzy takes an array instead of 5 arguments for it's dice
  def self.yatzy(dice)
    new(*dice).yatzy
  end

  def self.ones(*dice)
    new(*dice).single(1)
  end

  def self.twos(*dice)
    new(*dice).single(2)
  end

  def self.threes(*dice)
    new(*dice).single(3)
  end

  def fours
    single(4)
  end

  def fives
    single(5)
  end

  def sixes
    single(6)
  end

  def self.score_pair(*dice)
    new(*dice).n_of_a_kind(2)
  end

  def self.two_pair(*dice)
    new(*dice).two_pair
  end

  def self.four_of_a_kind(*dice)
    new(*dice).n_of_a_kind(4)
  end

  def self.three_of_a_kind(*dice)
    new(*dice).n_of_a_kind(3)
  end

  def self.smallStraight(*dice) # rubocop:todo Naming/MethodName
    return 15 if dice.sort == [1, 2, 3, 4, 5]

    0
  end

  def self.largeStraight(*dice) # rubocop:todo Naming/MethodName
    return 20 if dice.sort == [2, 3, 4, 5, 6]

    0
  end

  def self.fullHouse(*dice) # rubocop:todo Naming/MethodName
    new(*dice).full_house
  end
end
