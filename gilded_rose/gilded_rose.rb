class GildedRose
  def initialize(items)
    @items = items.map do |item|
      klass_for(item).new(item.name, item.sell_in, item.quality)
    end
  end

  def klass_for(item)
    case item.name
    when "Aged Brie"
      AgedBrie
    when "Sulfuras, Hand of Ragnaros"
      Sulfuras
    when "Backstage passes to a TAFKAL80ETC concert"
      BackstagePass
    else
      Normal
    end
  end

  def update_quality
    @items = @items.map do |item|
      item.update
      item
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

class Normal < Item
  def update
    @quality -= 1
    @sell_in -= 1
    @quality = 0 if quality.negative?
  end
end

class AgedBrie < Item
  def update
    @quality += 1
    @quality += 1 if @sell_in <= 0

    @quality = 50 if @quality > 50
    @sell_in -= 1
  end
end

class Sulfuras < Item
  def update; end
end

class BackstagePass < Item
  def update
    @quality += 1
    @quality += 1 if @sell_in < 11
    @quality += 1 if @sell_in < 6
    @quality = 0 if @sell_in <= 0

    @quality = 50 if @quality > 50

    @sell_in -= 1
  end
end
