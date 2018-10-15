class RandomGenerator
  def only_alphabet(length)
    random_string(length, alphabet)
  end

  def letters_and_numbers(length)
    random_string(length, alphabet + numbers)
  end

  def only_numbers(length)
    random_string(length, numbers)
  end

  private
  def random_string(length, charset)
    Array.new(length) { charset.sample }.join
  end

  def alphabet
    @alphabet ||= Array('A'..'Z') + Array('a'..'z')
  end

  def numbers
    @numbers ||= Array(0 .. 9)
  end
end