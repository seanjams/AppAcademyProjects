class XmlDocument
  attr_reader :indent, :sp
  
  def initialize(indent = false)
    @indent = indent
    @sp = ""
  end
    
  def send(tag_name)
    indent ? "<#{tag_name}/>\n": "<#{tag_name}/>"
  end
  
  def method_missing(method_name, *args, &prc)
    head = method_name.to_s
    foot = head
    
    if args[0].is_a?(Hash)
      attrib, val = args[0].keys[0], args[0].values[0]
      head += " #{attrib}=\"#{val}\""
    end
    
    make_tag(head, foot, prc)
  end
  
  private
  
  def make_tag(head, foot, prc)
    if prc
      str_beg = indent ? "<#{head}>\n": "<#{head}>"
      str_end = indent ? "#{sp}</#{foot}>\n": "</#{foot}>"
      @sp += "  " if indent
      str_mid = indent ? "#{sp}#{prc.call}": "#{prc.call}"
      
      "#{str_beg}#{str_mid}#{str_end}"
    else
      indent ? "<#{head}/>\n": "<#{head}/>"
    end
  end

end