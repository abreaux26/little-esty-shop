class Contributor
  attr_reader :user_name

  def initialize(data)
    @user_name = data[:login]
  end
end
