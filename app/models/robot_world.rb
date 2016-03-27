require 'yaml/store'
require 'pry'

class RobotWorld
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    if robot.values.all? {|value| value.empty?}
      robot = fake_robot
      raw_robots.insert(robot)
    else
      raw_robots.insert(robot)
    end
  end

  def fake_robot
    name = Faker::Name.name
    city = Faker::Address.city
    state = Faker::Address.state
    birthdate = Faker::Date.birthday.strftime("%F")
    date_hired = Faker::Date.between(birthdate, Date.today)
    department = Faker::Commerce.department(1)
    photo = Faker::Avatar.image
    {"name"=>name, "city"=>city, "state"=>state, "birthdate"=>birthdate, "date_hired"=>date_hired, "department"=>department, "photo"=>photo}
  end

  def raw_robots
    database.from(:robots)
  end

  def all
    raw_robots.map {|robot| Robot.new(robot)}
  end

  def find(id)
    all.find {|robot| robot.id == id}
  end

  def update(id, robot)
    raw_robots.where(:id => id).update(robot)
  end

  def delete(id)
    raw_robots.where(:id => id).delete
  end

  def find_by_name(name)
    potential_robot_matches = all.find_all do |robot|
      name.downcase.chars.all? do |letter|
        robot.name.downcase.include?(letter)
      end
    end
    filter_matches(potential_robot_matches, name)
  end

  def filter_matches(potential_matches, name)
    potential_matches.find_all do |robot|
      robot.name.downcase.chars.all? do |letter|
        name.downcase.count(letter) <= robot.name.downcase.count(letter)
      end
    end
  end

  def delete_all
    raw_robots.delete
  end

  def birthyears
    raw_robots.map do |robot_hash|
      robot_hash[:birthdate].split("-")[0].to_i
    end
  end

  def average_age
    avg_birthyear = birthyears.reduce(:+)/birthyears.count.to_f
    (Date.today.strftime("%Y").to_i - avg_birthyear).round(2)
  end

  def hired_by_year
    hiring_dates = all.map do |robot|
      robot.date_hired.split("-").first.to_i
    end
    calc_robot_data(hiring_dates)
  end

  def robots_per_dept
    department_data = all.map {|robot|robot.department}
    calc_robot_data(department_data)
  end


  def robots_per_city
    city_data = all.map {|robot| robot.city}
    calc_robot_data(city_data)
  end

  def robots_per_state
    state_data = all.map {|robot| robot.state}
    calc_robot_data(state_data)
  end

  def calc_robot_data(dataset)
    dataset.reduce(Hash.new(0)) do |acc, data|
      acc[data] += 1
      acc
    end
  end

end
