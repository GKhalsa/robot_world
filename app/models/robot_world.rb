require 'yaml/store'
require 'pry'

class RobotWorld
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    raw_robots.insert(robot)
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

end
