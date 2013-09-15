class Utilities

  def self.deep_dup(source)
    case source
    when Array
      duplicate = source.dup
      duplicate.each_with_index do |v, i|
        duplicate[i] = self.deep_dup(v)
      end
      return duplicate
    when Hash
      duplicate = source.dup
      duplicate.each_pair do |k,v|
        duplicate[k] = self.deep_dup(v)
      end
      return duplicate
    end

    return source
  end


end