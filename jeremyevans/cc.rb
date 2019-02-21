class CC
  def self.process(*strings)
    validate(strings.join)
  end

  def self.validate(number)
    case number
    when /\D/
      # Non digit in card number
      return false
    when /\A3[47]/
      return false unless number.length == 15
    when /\A(6011|5[1-5])/ 
      return false unless number.length == 16
    when /\A4/
      return false unless number.length == 16 || number.length == 13
    else
      return false
    end

    luhn(number) == 0
  end

  def self.luhn(number)
    digits = number.split(//).map(&:to_i)
    (-(number.length - 2)..0).step(2) do |i|
      value = digits[-i] *= 2
      if value >= 10
        digits[-i] = 1 + value % 10
      end
    end
    digits.sum % 10
  end

  TYPES = {
    1 => [%w"34 37", [15]],
    2 => [%w"6011", [16]],
    3 => [%w"51 52 53 54 55", [16]],
    4 => [%w"4", [13,16]]
  }

  def self.generate(type_id)
    starts, lengths = TYPES[type_id]
    return false unless starts

    start = starts.sample
    length = lengths.sample
    number = "#{start}#{(length-start.length-1).times.map{rand(10)}.join}"
    number += ((10 - luhn(number + '0')) % 10).to_s
  end
end
