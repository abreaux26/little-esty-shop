class Repo
  attr_reader :name

  def initialize(name)
    @name = name.split("-").map(&:capitalize).join(" ")
  end
end
