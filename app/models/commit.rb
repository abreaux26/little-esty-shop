class Commit
  attr_reader :name

  def initialize(data)
    @name = data[:author][:name]
    @sha = data[:sha]
  end
end
