require "rspec"

require File.join(File.dirname(__FILE__), "gilded_rose")

# > Make the change easy (warning: this may be hard), then make the easy change. -- Kent Beck

#
# - Once the sell by date has passed, `Quality` degrades twice as fast
# - The `Quality` of an item is never negative
#   - __"Aged Brie"__ actually increases in `Quality` the older it gets
#   - The `Quality` of an item is never more than `50`
#   - __"Sulfuras"__, being a legendary item, never has to be sold or decreases in `Quality`
#   - __"Backstage passes"__, like aged brie, increases in `Quality` as its `SellIn` value approaches;
#     - `Quality` increases by `2` when there are `10` days or less and by `3` when there are `5` days
#        or less but
#     - `Quality` drops to `0` after the concert
# We have recently signed a supplier of conjured items. This requires an update to our system:
# - __"Conjured"__ items degrade in `Quality` twice as fast as normal items
#
#
# Item(name, sell_in, quality)
# rubocop:disable Metrics/BlockLength

describe GildedRose do
  context "with a normal item" do
    it "decreases the quality by 1" do
      items = [Item.new("foo", 2, 1)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end

    it "decreases the sell in by 1" do
      items = [Item.new("foo", 2, 1)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq 1
    end

    context "when the quality is 0" do
      it "does not decrease the quality" do
        items = [Item.new("foo", 2, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 0
      end
    end
  end
  #   - __"Aged Brie"__ actually increases in `Quality` the older it gets
  context "when the item is Aged Brie" do
    context "when the quality is less than 50" do
      it "increases the quality by 1" do
        items = [Item.new("Aged Brie", 2, 1)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 2
      end
    end

    #   - The `Quality` of an item is never more than `50`
    context "when the quality is 50" do
      it "does not increase the quality" do
        items = [Item.new("Aged Brie", 2, 50)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 50
      end
    end

    context "when the item is passed the sell by date" do
      it "increases the quality by 2" do
        items = [Item.new("Aged Brie", 0, 1)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 3
      end
    end
  end
  # - __"Sulfuras"__, being a legendary item, never has to be sold or decreases in `Quality`
  context "when the item is Sulfuras" do
    it "does not change the quality" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 2, 40)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 40
    end
  end
  #   - __"Backstage passes"__, like aged brie, increases in `Quality` as its `SellIn` value approaches;
  #     - `Quality` increases by `2` when there are `10` days or less and
  #   -  by `3` when there are `5` days
  #        or less but
  #     - `Quality` drops to `0` after the concert
  context "when the item is Backstage passes" do
    context "when the are more than 10 days to sell in" do
      context "when the quality is less than 50" do
        it "increases quality by 1" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 1)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq 2
        end
      end
      context "when the quality is 50" do
        it "does not increase the quality" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq 50
        end
      end
    end

    context "when the are 10 days or less to sell in" do
      context "when the quality is less than 50" do
        it "increases quality by 2" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 1)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq 3
        end
      end

      context "when the quality is 49" do
        it "increases quality to the max quality of 50" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 49)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq 50
        end
      end

      context "when the quality is 50" do
        it "does not increase the quality" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq 50
        end
      end
    end

    context "when the are 5 days or less to sell in" do
      context "when the quality is less than 50" do
        it "increases quality by 3" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 1)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq 4
        end
      end

      context "when the quality is 48" do
        it "increases quality to the max quality of 50" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 48)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq 50
        end
      end

      context "when the quality is 50" do
        it "does not increase the quality" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq 50
        end
      end
    end

    context "when the are 0 days to sell in" do
      it "drops the quality to 0" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 1)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 0
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
