class GildedRose
  def initialize(items)
    @items = items
  end

  # rubocop:todo Metrics/MethodLength
  def update_quality # rubocop:todo Metrics/MethodLength
    @items = @items.map do |item|
      case item.name
      when "Aged Brie"
        update_aged_brie(item)
      when "Sulfuras, Hand of Ragnaros"
        update_sulfuras(item)
      when "Backstage passes to a TAFKAL80ETC concert"
        update_backstage_passes(item)
      else
        update_normal_item(item)
      end
    end
  end

  def update_aged_brie(item)
    item = AgedBrie.new(item.name, item.sell_in, item.quality)
    item.update
    item
    # item.quality += 1
    # item.quality += 1 if item.sell_in <= 0

    # item.quality = 50 if item.quality > 50
    # item.sell_in -= 1
  end

  def update_sulfuras(item)
    item = Sulfuras.new(item.name, item.sell_in, item.quality)
    item.update
    item
  end

  def update_backstage_passes(item)
    item = BackstagePass.new(item.name, item.sell_in, item.quality)
    item.update
    item
  end

  def update_normal_item(item)
    item = Normal.new(item.name, item.sell_in, item.quality)
    item.update
    item
  end

  # rubocop:enable Metrics/MethodLength
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
