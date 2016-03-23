class Robot
  attr_reader :name, :city, :state,
              :birthdate, :date_hired,
              :department, :id

  def initialize(robot)
    @id         = robot["id"]
    @name       = robot["name"]
    @city       = robot["city"]
    @state      = robot["state"]
    @birthdate  = robot["birthdate"]
    @date_hired = robot["date_hired"]
    @department = robot["department"]
  end

end
