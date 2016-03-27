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
    all.find do |robot|
      robot.name.downcase.include?(name.downcase)
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

  def years_hired
    raw_robots.map do |robot_hash|
      robot_hash[:date_hired].split("-").first.to_i
    end
  end

  def hired_by_year
    x = years_hired.reduce(Hash.new(0)) do |acc, year|
      acc[year] += 1
      acc
    end
  end

end
