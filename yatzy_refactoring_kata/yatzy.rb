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
      return total
    end

    def yatzy(dice)
      counts = [0]*(dice.length+1)
      for die in dice do
        counts[die-1] += 1
      end
      for i in 0..counts.size do
        if counts[i] == 5
          return 50
        end
      end
      return 0
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

    def score_pair( d1,  d2,  d3,  d4,  d5)
      counts = [0]*6
      counts[d1-1] += 1
      counts[d2-1] += 1
      counts[d3-1] += 1
      counts[d4-1] += 1
      counts[d5-1] += 1
      at = 0
      (0...6).each do |at|
        if (counts[6-at-1] >= 2)
          return (6-at)*2
        end
      end
      return 0
    end

    def two_pair( d1,  d2,  d3,  d4,  d5)
      counts = [0]*6
      counts[d1-1] += 1
      counts[d2-1] += 1
      counts[d3-1] += 1
      counts[d4-1] += 1
      counts[d5-1] += 1
      n = 0
      score = 0
      for i in Array 0..5
        if (counts[6-i-1] >= 2)
          n = n+1
          score += (6-i)
        end
      end
      if (n == 2)
        return score * 2
      else
        return 0
      end
    end

    def four_of_a_kind( _one,  _two,  d3,  d4,  d5)
      tallies = [0]*6
      tallies[_one-1] += 1
      tallies[_two-1] += 1
      tallies[d3-1] += 1
      tallies[d4-1] += 1
      tallies[d5-1] += 1
      for i in (0..6)
        if (tallies[i] >= 4)
          return (i+1) * 4
        end
      end
      return 0
    end

    def three_of_a_kind( d1,  d2,  d3,  d4,  d5)
      t = [0]*6
      t[d1-1] += 1
      t[d2-1] += 1
      t[d3-1] += 1
      t[d4-1] += 1
      t[d5-1] += 1
      for i in [0,1,2,3,4,5]
        if (t[i] >= 3)
          return (i+1) * 3
        end
      end
      0
    end

    def smallStraight( d1,  d2,  d3,  d4,  d5)
      tallies = [0]*6
      tallies[d1-1] += 1
      tallies[d2-1] += 1
      tallies[d3-1] += 1
      tallies[d4-1] += 1
      tallies[d5-1] += 1
      (tallies[0] == 1 and
       tallies[1] == 1 and
       tallies[2] == 1 and
       tallies[3] == 1 and
       tallies[4] == 1) ? 15 : 0
    end

    def largeStraight( d1,  d2,  d3,  d4,  d5)
      tallies = [0]*6
      tallies[d1-1] += 1
      tallies[d2-1] += 1
      tallies[d3-1] += 1
      tallies[d4-1] += 1
      tallies[d5-1] += 1
      if (tallies[1] == 1 and tallies[2] == 1 and tallies[3] == 1 and tallies[4] == 1 and tallies[5] == 1)
        return 20
      end
      return 0
    end

    def fullHouse( d1,  d2,  d3,  d4,  d5)
      tallies = []
      _two = false
      i = 0
      _two_at = 0
      _three = false
      _three_at = 0

      tallies = [0]*6
      tallies[d1-1] += 1
      tallies[d2-1] += 1
      tallies[d3-1] += 1
      tallies[d4-1] += 1
      tallies[d5-1] += 1

      for i in Array 0..5
        if (tallies[i] == 2)
          _two = true
          _two_at = i+1
        end
      end

      for i in Array 0..5
        if (tallies[i] == 3)
          _three = true
          _three_at = i+1
        end
      end

      if (_two and _three)
        return _two_at * 2 + _three_at * 3
      else
        return 0
      end
    end

    private 

    def singles(d1, d2, d3, d4, d5, value)
      sum = 0
      if (d1 == value)
        sum += value
      end
      if (d2 == value)
        sum += value
      end
      if (d3 == value)
        sum += value
      end
      if (d4 == value)
        sum += value
      end
      if (d5 == value)
        sum += value
      end

      sum
    end

    def of_a_kind(d1, d2, d3, d4, d5, count)
      t = [0]*6
      t[d1-1] += 1
      t[d2-1] += 1
      t[d3-1] += 1
      t[d4-1] += 1
      t[d5-1] += 1
      for i in [0,1,2,3,4,5]
        if (t[i] >= count)
          return (i+1) * count
        end
      end
      0
    end

  end

  def fours
    sum = 0
    for at in Array 0..4
      if (@dice[at] == 4)
        sum += 4
      end
    end
    return sum
  end

  def fives()
    s = 0
    i = 0
    for i in (Range.new(0, @dice.size))
      if (@dice[i] == 5)
        s = s + 5
      end
    end
    s
  end

  def sixes
    sum = 0
    for at in 0..@dice.length
      if (@dice[at] == 6)
        sum = sum + 6
      end
    end
    return sum
  end
end
