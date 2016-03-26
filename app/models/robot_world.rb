require 'yaml/store'
require 'pry'
class RobotWorld
  attr_reader :database,
              :robots

  def initialize(database)
    @database = database
  end

  def create(robot)
    @robots = database.from(:robots)
    robots.insert(robot)
  end

  def raw_robots
    database.transaction do
      database['robots'] || []
    end
  end

  def all
    robots.map {|robot| Robot.new(robot)}
  end

  def find(id)
    all.find {|robot| robot.id == id}
  end

  def update(id, robot)
    robots.where(:id => id).update(robot)
  end

  def delete(id)
    robots.where(:id => id).delete
  end

  def find_by_name(name)
    all.find do |robot|
      robot.name.downcase.include?(name.downcase)
    end
  end

  def delete_all
    robots.delete
  end

end
