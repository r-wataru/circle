# coding: utf-8
# n(L) = L × (L - 1) + 1
# N(X) = {1,2,3,...,n(L)}
# 解答が存在しない場合「Nothing」
require 'pp'

class Circle
  def initialize(l)
    @n = l * (l - 1) + 1
    @sums = []
    @n.times do |nn|
      @sums << nn + 1
    end
    @answers = []
    answer
  end
  
  def arr_count
    arr1 = []
    @sums.each_with_index do |a,i|
      if i == 0
        arr1 << [a]
      else
        arr = []
        arr1[i-1].each do |n|
          arr << n
        end
        arr.push(a)
        arr1 << arr
      end
    end
    arr1.select{|a| a if a.inject(:+) <= @sums.last }.count
  end
  
  def arr_after
    last_number = @sums.last
    arr = []
    arr_count.times do |i|
      arr << @sums.combination(i + 1).to_a
    end
    arr.map{|a| a.map{|b| b if b.inject(:+) == last_number}.compact }
  end
  
  def answer
    arr = []
    arr_after.each do |a|
      a.each do |b|
        arr1 = []
        b.count.times do |i|
          arr1 << b.combination(i).to_a
        end
        arr << arr1
      end
    end
    arrays = arr.map{|a| a.map{|b| b.map{|c| c.inject(:+)}}.flatten.uniq.compact.sort }
    numbers = []
    arrays.each_with_index do |a,i|
      if a.count == (@sums.last - 1)
        numbers << i
      end
    end
    if numbers.count > 0
      numbers.each do |n|
        @answers << arr[n][1].flatten
      end
    else
      @answers << "Nothing"
    end
    pp @answers
  end
end

puts Circle.new(4)
