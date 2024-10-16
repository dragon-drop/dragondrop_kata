class GildedRose
  def initialize(items)
    @items = items
  end

  # rubocop:todo Metrics/MethodLength
  def update_quality # rubocop:todo Metrics/MethodLength
    @items.each do |item|
      next update_aged_brie(item) if item.name == "Aged Brie"
      next update_sulfuras(item) if item.name == "Sulfuras, Hand of Ragnaros"
      next update_backstage_passes(item) if item.name == "Backstage passes to a TAFKAL80ETC concert"

      update_normal_item(item)
    end
  end

  def update_aged_brie(item)
    item.quality += 1
    item.quality += 1 if item.sell_in <= 0

    item.quality = 50 if item.quality > 50
    item.sell_in -= 1
  end

  def update_sulfuras(_item); end

  def update_backstage_passes(item)
    item.quality += 1
    item.quality += 1 if item.sell_in < 11
    item.quality += 1 if item.sell_in < 6
    item.quality = 0 if item.sell_in <= 0

    item.quality = 50 if item.quality > 50

    item.sell_in -= 1
  end

  def update_normal_item(item)
    item.quality -= 1
    item.sell_in -= 1
    item.quality = 0 if item.quality.negative?
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
