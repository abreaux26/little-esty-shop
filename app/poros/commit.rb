class Commit
  attr_reader :name

  def initialize(data)
    @name = data[:commit][:author][:name]
    @sha = data[:sha]
  end
end
