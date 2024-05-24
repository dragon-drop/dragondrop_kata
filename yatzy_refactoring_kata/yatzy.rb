class Yatzy # rubocop:todo Metrics/ClassLength
  def initialize(*dice)
    @dice = *dice
    @tally = @dice.tally
  end

  def self.chance(*dice)
    dice.sum
  end

  def self.yatzy(dice) # rubocop:todo Metrics/MethodLength
    counts = [0] * (dice.length + 1)
    dice.each do |die|
      counts[die - 1] += 1
    end
    (0..counts.size).each do |i|
      return 50 if counts[i] == 5
    end
    0
  end

  # rubocop:todo Naming/MethodParameterName
  # rubocop:todo Metrics/ParameterLists
  def self.ones(d1, d2, d3, d4, d5) # rubocop:todo Metrics/MethodLength, Metrics/ParameterLists, Naming/MethodParameterName
    # rubocop:enable Metrics/ParameterLists
    # rubocop:enable Naming/MethodParameterName
    sum = 0
    sum += 1 if d1 == 1
    sum += 1 if d2 == 1
    sum += 1 if d3 == 1
    sum += 1 if d4 == 1
    sum += 1 if d5 == 1

    sum
  end

  # rubocop:todo Naming/MethodParameterName
  # rubocop:todo Metrics/ParameterLists
  def self.twos(d1, d2, d3, d4, d5) # rubocop:todo Metrics/MethodLength, Metrics/ParameterLists, Naming/MethodParameterName
    # rubocop:enable Metrics/ParameterLists
    # rubocop:enable Naming/MethodParameterName
    sum = 0
    sum += 2 if d1 == 2
    sum += 2 if d2 == 2
    sum += 2 if d3 == 2
    sum += 2 if d4 == 2
    sum += 2 if d5 == 2
    sum
  end

  # rubocop:todo Naming/MethodParameterName
  # rubocop:todo Metrics/ParameterLists
  def self.threes(d1, d2, d3, d4, d5) # rubocop:todo Metrics/MethodLength, Metrics/ParameterLists, Naming/MethodParameterName
    # rubocop:enable Metrics/ParameterLists
    # rubocop:enable Naming/MethodParameterName
    s = 0
    s += 3 if d1 == 3
    s += 3 if d2 == 3
    s += 3 if d3 == 3
    s += 3 if d4 == 3
    s += 3 if d5 == 3
    s
  end

  def fours
    sum = 0
    (0..4).each do |at|
      sum += 4 if @dice[at] == 4
    end
    sum
  end

  def fives
    s = 0
    Range.new(0, @dice.size).each do |i|
      s += 5 if @dice[i] == 5
    end
    s
  end

  def sixes
    sum = 0
    (0..@dice.length).each do |at|
      sum += 6 if @dice[at] == 6
    end
    sum
  end

  # rubocop:todo Metrics/MethodLength
  # rubocop:todo Naming/MethodParameterName
  # rubocop:todo Metrics/ParameterLists
  def self.score_pair(d1, d2, d3, d4, d5) # rubocop:todo Metrics/AbcSize, Metrics/MethodLength, Metrics/ParameterLists, Naming/MethodParameterName
    # rubocop:enable Metrics/ParameterLists
    # rubocop:enable Naming/MethodParameterName
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
  # rubocop:enable Metrics/MethodLength

  # rubocop:todo Metrics/MethodLength
  # rubocop:todo Naming/MethodParameterName
  # rubocop:todo Metrics/ParameterLists
  def self.two_pair(d1, d2, d3, d4, d5) # rubocop:todo Metrics/AbcSize, Metrics/MethodLength, Metrics/ParameterLists, Naming/MethodParameterName
    # rubocop:enable Metrics/ParameterLists
    # rubocop:enable Naming/MethodParameterName
    counts = [0] * 6
    counts[d1 - 1] += 1
    counts[d2 - 1] += 1
    counts[d3 - 1] += 1
    counts[d4 - 1] += 1
    counts[d5 - 1] += 1
    n = 0
    score = 0
    (0..5).each do |i|
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
  # rubocop:enable Metrics/MethodLength

  # rubocop:todo Metrics/MethodLength
  # rubocop:todo Naming/MethodParameterName
  # rubocop:todo Metrics/ParameterLists
  def self.four_of_a_kind(_one, _two, d3, d4, d5) # rubocop:todo Lint/UnderscorePrefixedVariableName, Metrics/MethodLength, Metrics/ParameterLists, Naming/MethodParameterName
    # rubocop:enable Metrics/ParameterLists
    # rubocop:enable Naming/MethodParameterName
    tallies = [0] * 6
    tallies[_one - 1] += 1
    tallies[_two - 1] += 1
    tallies[d3 - 1] += 1
    tallies[d4 - 1] += 1
    tallies[d5 - 1] += 1
    (0..6).each do |i|
      return (i + 1) * 4 if tallies[i] >= 4
    end
    0
  end
  # rubocop:enable Metrics/MethodLength

  # rubocop:todo Naming/MethodParameterName
  # rubocop:todo Metrics/ParameterLists
  def self.three_of_a_kind(d1, d2, d3, d4, d5) # rubocop:todo Metrics/MethodLength, Metrics/ParameterLists, Naming/MethodParameterName
    # rubocop:enable Metrics/ParameterLists
    # rubocop:enable Naming/MethodParameterName
    t = [0] * 6
    t[d1 - 1] += 1
    t[d2 - 1] += 1
    t[d3 - 1] += 1
    t[d4 - 1] += 1
    t[d5 - 1] += 1
    [0, 1, 2, 3, 4, 5].each do |i|
      return (i + 1) * 3 if t[i] >= 3
    end
    0
  end

  # rubocop:todo Metrics/MethodLength
  # rubocop:todo Naming/MethodParameterName
  # rubocop:todo Naming/MethodName
  # rubocop:todo Metrics/ParameterLists
  def self.smallStraight(d1, d2, d3, d4, d5) # rubocop:todo Metrics/AbcSize, Metrics/MethodLength, Metrics/ParameterLists, Naming/MethodName, Naming/MethodParameterName
    # rubocop:enable Metrics/ParameterLists
    # rubocop:enable Naming/MethodName
    # rubocop:enable Naming/MethodParameterName
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
  # rubocop:enable Metrics/MethodLength

  # rubocop:todo Metrics/MethodLength
  # rubocop:todo Naming/MethodParameterName
  # rubocop:todo Naming/MethodName
  # rubocop:todo Metrics/ParameterLists
  def self.largeStraight(d1, d2, d3, d4, d5) # rubocop:todo Metrics/AbcSize, Metrics/MethodLength, Metrics/ParameterLists, Naming/MethodName, Naming/MethodParameterName
    # rubocop:enable Metrics/ParameterLists
    # rubocop:enable Naming/MethodName
    # rubocop:enable Naming/MethodParameterName
    tallies = [0] * 6
    tallies[d1 - 1] += 1
    tallies[d2 - 1] += 1
    tallies[d3 - 1] += 1
    tallies[d4 - 1] += 1
    tallies[d5 - 1] += 1
    return 20 if tallies[1] == 1 && tallies[2] == 1 && tallies[3] == 1 && tallies[4] == 1 && tallies[5] == 1

    0
  end
  # rubocop:enable Metrics/MethodLength

  # rubocop:todo Metrics/MethodLength
  # rubocop:todo Naming/MethodParameterName
  # rubocop:todo Naming/MethodName
  # rubocop:todo Metrics/ParameterLists
  def self.fullHouse(d1, d2, d3, d4, d5) # rubocop:todo Metrics/AbcSize, Metrics/MethodLength, Metrics/ParameterLists, Naming/MethodName, Naming/MethodParameterName
    # rubocop:enable Metrics/ParameterLists
    # rubocop:enable Naming/MethodName
    # rubocop:enable Naming/MethodParameterName
    tallies = []
    two = false
    two_at = 0
    three = false
    three_at = 0

    tallies = [0] * 6
    tallies[d1 - 1] += 1
    tallies[d2 - 1] += 1
    tallies[d3 - 1] += 1
    tallies[d4 - 1] += 1
    tallies[d5 - 1] += 1

    (0..5).each do |i| # rubocop:todo Metrics/BlockLength
      if tallies[i] == 2
        two = true
        two_at = i + 1
      end

      if tallies[i] == 3
        three = true
        three_at = i + 1
      end
    end

    if two && three
      (two_at * 2) + (three_at * 3)
    else
      0
    end
  end
  # rubocop:enable Metrics/MethodLength
end
