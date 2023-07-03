class TwoFerAnalyzer < Crystal::Visitor
  @comment : Array(Comments) = Array(Comments).new
  getter(comment)
  inside_method = false

  def visit(node : Crystal::Def)
    if node.name == "two_fer" && node.args[0].default_value != "you"
      @comment << Comments.new("crystal.two-fer.no_def_arg", Hash(String, String | Int32).new, "warrning")
      @inside_method = true
    end
    true
  end

  def visit(node : Crystal::Call)
    if node.name == "+" && (node.args[0].class == Crystal::StringLiteral || node.obj.class == Crystal::StringLiteral)
      unless @comment.any? { |x| x.comment.includes?("crystal.two-fer.string_format")}
      p "here"
        @comment << Comments.new("crystal.two-fer.string_format", Hash(String, String | Int32).new, "warrning")
      end
    end
    true
  end

  def end_visit(node : Crystal::Def)
    @inside_method = false
  end

  def visit(node)
    true
  end
end
