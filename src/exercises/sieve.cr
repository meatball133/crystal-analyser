class SieveAnalyzer < Crystal::Visitor
  @comment : Array(Comments) = Array(Comments).new
  getter(comment)

  def visit(node : Crystal::Call)
    if node.name == "/" || node.name == "%"
      @comment << Comments.new("crystal.sieve.do_not_use_div", Hash(String, String | Int32).new, "error")
      return false
    end
    true
  end

  def visit(node)
    true
  end
end
