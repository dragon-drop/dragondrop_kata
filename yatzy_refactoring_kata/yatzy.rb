class Yatzy
  def initialize(d1, d2, d3, d4, d5)
    @dice = [d1, d2, d3, d4, d5]
  end

  class << self
    def chance(d1, d2, d3, d4, d5)
      total = 0
      total += d1
      total += d2
      total += d3
      total += d4
      total += d5
      total
    end

    def yatzy(dice)
      counts = [0] * (dice.length + 1)
      for die in dice do
        counts[die - 1] += 1
      end
      for i in 0..counts.size do
        return 50 if counts[i] == 5
      end
      0
    end

    def ones(*args)
      singles(*args, 1)
    end

    def twos(*args)
      singles(*args, 2)
    end

    def threes(*args)
      singles(*args, 3)
    end

    def score_pair(d1, d2, d3, d4, d5)
      counts = [0] * 6
      counts[d1 - 1] += 1
      counts[d2 - 1] += 1
      counts[d3 - 1] += 1
      counts[d4 - 1] += 1
      counts[d5 - 1] += 1
      (0...6).each do |at|
        return (6 - at) * 2 if counts[6 - at - 1] >= 2
      end
      0
    end

    def two_pair(d1, d2, d3, d4, d5)
      counts = [0] * 6
      counts[d1 - 1] += 1
      counts[d2 - 1] += 1
      counts[d3 - 1] += 1
      counts[d4 - 1] += 1
      counts[d5 - 1] += 1
      n = 0
      score = 0
      for i in Array 0..5
        if counts[6 - i - 1] >= 2
          n += 1
          score += (6 - i)
        end
      end
      if n == 2
        score * 2
      else
        0
      end
    end

    def four_of_a_kind(*args)
      of_a_kind(*args, 4)
    end

    def three_of_a_kind(*args)
      of_a_kind(*args, 3)
    end

    def smallStraight(d1, d2, d3, d4, d5)
      tallies = [0] * 6
      tallies[d1 - 1] += 1
      tallies[d2 - 1] += 1
      tallies[d3 - 1] += 1
      tallies[d4 - 1] += 1
      tallies[d5 - 1] += 1
      if tallies[0] == 1 &&
         tallies[1] == 1 &&
         tallies[2] == 1 &&
         tallies[3] == 1 &&
         tallies[4] == 1
        15
      else
        0
      end
    end

    def largeStraight(d1, d2, d3, d4, d5)
      tallies = [0] * 6
      tallies[d1 - 1] += 1
      tallies[d2 - 1] += 1
      tallies[d3 - 1] += 1
      tallies[d4 - 1] += 1
      tallies[d5 - 1] += 1
      return 20 if tallies[1] == 1 && tallies[2] == 1 && tallies[3] == 1 && tallies[4] == 1 && tallies[5] == 1

      0
    end

    def fullHouse(d1, d2, d3, d4, d5)
      tallies = []
      _two = false
      i = 0
      _two_at = 0
      _three = false
      _three_at = 0

      tallies = [0] * 6
      tallies[d1 - 1] += 1
      tallies[d2 - 1] += 1
      tallies[d3 - 1] += 1
      tallies[d4 - 1] += 1
      tallies[d5 - 1] += 1

      for i in Array 0..5
        if tallies[i] == 2
          _two = true
          _two_at = i + 1
        end
      end

      for i in Array 0..5
        if tallies[i] == 3
          _three = true
          _three_at = i + 1
        end
      end

      if _two && _three
        (_two_at * 2) + (_three_at * 3)
      else
        0
      end
    end

    private

    def singles(d1, d2, d3, d4, d5, value)
      sum = 0
      sum += value if d1 == value
      sum += value if d2 == value
      sum += value if d3 == value
      sum += value if d4 == value
      sum += value if d5 == value

      sum
    end

    def of_a_kind(d1, d2, d3, d4, d5, count)
      dice = [d1, d2, d3, d4, d5]
      tally = dice.tally # => {3: 3, 4: 1, 5: 1}

      dice_value = tally.find { |_dice_value, dice_count| dice_count >= count }.first || 0
      dice_value * count
    end
  end

  def fours
    sum = 0
    for at in Array 0..4
      sum += 4 if @dice[at] == 4
    end
    sum
  end

  def fives
    s = 0
    i = 0
    for i in Range.new(0, @dice.size)
      s += 5 if @dice[i] == 5
    end
    s
  end

  def sixes
    sum = 0
    for at in 0..@dice.length
      sum += 6 if @dice[at] == 6
    end
    sum
  end

  def chance(d1, d2, d3, d4, d5)
    total = 0
    total += d1
    total += d2
    total += d3
    total += d4
    total += d5
    total
  end

  def yatzy(dice)
    counts = [0] * (dice.length + 1)
    for die in dice do
      counts[die - 1] += 1
    end
    for i in 0..counts.size do
      return 50 if counts[i] == 5
    end
    0
  end

  def ones(*args)
    singles(*args, 1)
  end

  def twos(*args)
    singles(*args, 2)
  end

  def threes(*args)
    singles(*args, 3)
  end

  def score_pair(d1, d2, d3, d4, d5)
    counts = [0] * 6
    counts[d1 - 1] += 1
    counts[d2 - 1] += 1
    counts[d3 - 1] += 1
    counts[d4 - 1] += 1
    counts[d5 - 1] += 1
    (0...6).each do |at|
      return (6 - at) * 2 if counts[6 - at - 1] >= 2
    end
    0
  end

  def two_pair(d1, d2, d3, d4, d5)
    counts = [0] * 6
    counts[d1 - 1] += 1
    counts[d2 - 1] += 1
    counts[d3 - 1] += 1
    counts[d4 - 1] += 1
    counts[d5 - 1] += 1
    n = 0
    score = 0
    for i in Array 0..5
      if counts[6 - i - 1] >= 2
        n += 1
        score += (6 - i)
      end
    end
    if n == 2
      score * 2
    else
      0
    end
  end

  def four_of_a_kind(*args)
    of_a_kind(*args, 4)
  end

  def three_of_a_kind(*args)
    of_a_kind(*args, 3)
  end

  def smallStraight(d1, d2, d3, d4, d5)
    tallies = [0] * 6
    tallies[d1 - 1] += 1
    tallies[d2 - 1] += 1
    tallies[d3 - 1] += 1
    tallies[d4 - 1] += 1
    tallies[d5 - 1] += 1
    if tallies[0] == 1 &&
        tallies[1] == 1 &&
        tallies[2] == 1 &&
        tallies[3] == 1 &&
        tallies[4] == 1
      15
    else
      0
    end
  end

  def largeStraight(d1, d2, d3, d4, d5)
    tallies = [0] * 6
    tallies[d1 - 1] += 1
    tallies[d2 - 1] += 1
    tallies[d3 - 1] += 1
    tallies[d4 - 1] += 1
    tallies[d5 - 1] += 1
    return 20 if tallies[1] == 1 && tallies[2] == 1 && tallies[3] == 1 && tallies[4] == 1 && tallies[5] == 1

    0
  end

  def fullHouse(d1, d2, d3, d4, d5)
    tallies = []
    _two = false
    i = 0
    _two_at = 0
    _three = false
    _three_at = 0

    tallies = [0] * 6
    tallies[d1 - 1] += 1
    tallies[d2 - 1] += 1
    tallies[d3 - 1] += 1
    tallies[d4 - 1] += 1
    tallies[d5 - 1] += 1

    for i in Array 0..5
      if tallies[i] == 2
        _two = true
        _two_at = i + 1
      end
    end

    for i in Array 0..5
      if tallies[i] == 3
        _three = true
        _three_at = i + 1
      end
    end

    if _two && _three
      (_two_at * 2) + (_three_at * 3)
    else
      0
    end
  end

  private

  def singles(d1, d2, d3, d4, d5, value)
    sum = 0
    sum += value if d1 == value
    sum += value if d2 == value
    sum += value if d3 == value
    sum += value if d4 == value
    sum += value if d5 == value

    sum
  end

  def of_a_kind(d1, d2, d3, d4, d5, count)
    dice = [d1, d2, d3, d4, d5]
    tally = dice.tally # => {3: 3, 4: 1, 5: 1}

    dice_value = tally.find { |_dice_value, dice_count| dice_count >= count }.first || 0
    dice_value * count
  end
end
