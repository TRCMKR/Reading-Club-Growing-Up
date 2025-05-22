# frozen_string_literal: true

class HashConverter
  def convert(hash)
    unless hash
      return {}
    end

    if hash.is_a?(Symbol)
      tmp = {}
      tmp[hash] = {}

      return tmp
    end

    if hash.is_a?(Array)
      tmp = {}
      hash.each do |elem|
        if elem.is_a?(Symbol)
          tmp[elem] = {}
        else
          tmp = tmp.merge(convert(elem))
        end
      end

      return tmp
    end

    hash.each do |key, value|
      hash[key] = convert(value)
    end

    hash
  end
end