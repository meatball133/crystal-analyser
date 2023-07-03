class ArysAmazingLasagnaAnalyzer < Crystal::Visitor
  @comment : Array(Comments) = Array(Comments).new
  getter(comment)

  @inside_method = ""
  @used_call = false
  @used_constant = false

  def visit(node : Crystal::Def)
    @inside_method = node.name
    true
  end

  def visit(node : Crystal::Assign)
    if @inside_method == "remaining_minutes_in_oven" && node.target.to_s == "EXPECTED_MINUTES_IN_OVEN"
      @used_constant = true
    end
    true
  end

  def visit(node : Crystal::Call)
    p node.name
    if @inside_method == "total_time_in_minutes" && node.name == "preparation_time_in_minutes"
      @used_call = true
    elsif @inside_method == "remaining_minutes_in_oven" && node.name == "-" && node.obj.to_s == "EXPECTED_MINUTES_IN_OVEN"
      @used_constant = true
    end
    true
  end

  def end_visit(node : Crystal::Def)
    if node.name == "total_time_in_minutes" && !@used_call
      @comment << Comments.new("crystal.arys-amazing-lasagna.no-call", Hash(String, String | Int32).new, "warrning")
    elsif node.name == "remaining_minutes_in_oven" && !@used_constant
      @comment << Comments.new("crystal.arys-amazing-lasagna.no-constant", Hash(String, String | Int32).new, "warrning")
    end
  end

  def visit(node)
    true
  end
end
