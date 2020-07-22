require './main'

describe Enumerable do
  block = proc { |num| num < (0 + 9) / 2 }

  describe '#my_each' do
    it 'compares .my_each with .each when using blocks' do
      expect([0, 1, 5, 10].my_each(&block)).to eql([0, 1, 5, 10].each(&block))
    end

    it 'compares .my_each with .each when using ranges' do
      expect((0..10).my_each(&block)).to eql((0..10).each(&block))
    end
  end

  describe '#my_each_with_index' do
    block = proc { |num| num < (0 + 9) / 2 }
    block2 = proc { |_k, v| v < (0 + 9) / 2 }

    it 'compares .my_each_with_index with .each_with_index using blocks' do
      expect([0, 1, 5, 10].my_each_with_index(&block)).to eql([0, 1, 5, 10].each_with_index(&block))
    end

    it 'compares .my_each_with_index with .each_with_index using blocks in a ranges' do
      expect((0..10).my_each_with_index(&block)).to eql((0..10).each_with_index(&block))
    end

    it 'compares .my_each_with_index with .each_with_index using hashes' do
      expect({ a: 1, b: 2, c: 3, d: 4, e: 5 }.my_each_with_index(&block2)).to eql({ a: 1, b: 2, c: 3, d: 4, e: 5 }.each_with_index(&block2))
    end
  end

  describe '#my_select' do
    block = proc { |num| num < (0 + 9) / 2 }

    it 'compares .my_select with .select using block as argument' do
      expect((0..10).my_select(&block)).to eql((0..10).select(&block))
    end

    it 'compares .my_select with .select for an array ' do
      expect([1, 2, 3, 4, 5].my_select(&:even?)).to eql([1, 2, 3, 4, 5].select(&:even?))
    end
  end

  describe '#my_all' do
    false_block = proc { |num| num > 100 }

    it 'compares .my_all with .all using block as argument on a range' do
      expect((0..10).my_all?(&false_block)).to eql((0..10).all?(&false_block))
    end

    it 'compares .my_all with .all for an array' do
      expect([1, 2, 3, 5].my_all?).to eql([1, 2, 3, 5].all?)
    end

    it 'compares .my_all with .all using a number as argument' do
      expect([1, 2, 3, 5].my_all?(3)).to eql([1, 2, 3, 5].all?(3))
    end

    it 'compares .my_all with .all using a Class as argument' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eql([1, 2i, 3.14].all?(Numeric))
    end

    it 'compares .my_all with .all using a Regexp as argument ' do
      expect(%w[ant bear cat].my_all?(/t/)).to eql(%w[ant bear cat].all?(/t/))
    end

    it 'compares .my_all with .all using block as argumenet on a strings array' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to eql(%w[ant bear cat].all? { |word| word.length >= 4 })
    end
  end

  describe '#my_any' do
    it 'compares .my_any with .any on a array' do
      expect([nil, false, false].my_any?).to eql([nil, false, false].any?)
    end

    it 'compares .my_any with .any with a number as argument' do
      expect([3, 4, 7, 11].my_any?(3)).to eql([3, 4, 7, 11].any?(3))
    end

    it 'compares .my_any with .any with a Class as argument' do
      expect([nil, true, 99].my_any?(Integer)).to eql([nil, true, 99].any?(Integer))
    end

    it 'compares .my_any with .any with a Regex as argument' do
      expect(%w[ant bear cat].my_any?(/d/)).to eql(%w[ant bear cat].any?(/d/))
    end

    it 'compares .my_any with .any with a block' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to eql(%w[ant bear cat].any? { |word| word.length >= 3 })
    end

    it 'compares .my_any with .any on an empty array' do
      expect([].my_any?).to eql([].any?)
    end
  end
end
