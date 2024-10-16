class GildedRose
  def initialize(items)
    @items = items
  end

  # rubocop:todo Metrics/MethodLength
  def update_quality # rubocop:todo Metrics/MethodLength
    @items.each do |item|
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
