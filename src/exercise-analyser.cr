require "compiler/crystal/syntax"
require "./exercises/*"
require "./analyzer"

class ExerciseAnayzer
  @result = Array(Comments).new
  getter result

  def initialize(exercise : String, path : String)
    file_content = File.read(path)
    case exercise
    when "sieve"
      analyser = SieveAnalyzer.new
      analyser.accept(Crystal::Parser.new(file_content).parse)
      @result = analyser.comment
    when "two-fer"
      analyser =  TwoFerAnalyzer.new
      analyser.accept(Crystal::Parser.new(file_content).parse)
      @result = analyser.comment
    when "arys-amazing-lasagna"
      analyser = ArysAmazingLasagnaAnalyzer.new
      analyser.accept(Crystal::Parser.new(file_content).parse)
      @result = analyser.comment
    end
  end
end
