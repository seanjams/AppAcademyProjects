class Dictionary
  attr_accessor :entries
  
  def initialize
    @entries = {}
  end
  
  def keywords
    entries.keys.sort
  end
  
  def add(entry)
    if entry.is_a?(Hash)
      entries.merge!(entry)
    elsif entry.is_a?(String)
      entries[entry] = nil
    end
  end
  
  def include?(keyword)
    entries.key?(keyword)
  end
  
  def find(str)
    entries.select { |key,ignore| key.include?(str) }
  end
  
  def printable
    sorted_entries = entries.sort_by{ |k,v| k }
    output = sorted_entries.map { |k,v| "[#{k}] \"#{v}\"" }
    output.join("\n")
  end
  
end
