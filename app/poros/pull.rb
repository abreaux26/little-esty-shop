class Pull
  attr_reader :user_name,
              :state
              
  def initialize(data)
    @user_name = data[:user][:login]
    @state = data[:state]
  end
end
