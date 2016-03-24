require 'yaml/store'

class RobotWorld
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    database.transaction do
      database['robots'] ||= []
      database['total'] ||= 0
      database['total'] += 1
      database['robots'] << {'id' => database['total'],
                           'name' => robot[:name],
                           'city' => robot[:city],
                          'state' => robot[:state],
                      'birthdate' => robot[:birthdate],
                     'date_hired' => robot[:date_hired],
                     'department' => robot[:department]}
    end
  end

  def raw_robots
    database.transaction do
      database['robots'] || []
    end
  end

  def all
    raw_robots.map {|robot| Robot.new(robot)}
  end

  def find(id)
    all.find {|robot| robot.id == id}
  end

  def update(id, robot)
    database.transaction do
      target = database['robots'].find {|robot| robot['id'] == id}
      target['name'] = robot[:name]
      target['city'] = robot[:city]
      target['state'] = robot[:state]
      target['birthdate'] = robot[:birthdate]
      target['date_hired'] = robot[:date_hired]
      target['department'] = robot[:department]
    end
  end

  def delete(id)
    database.transaction do
      database['robots'].delete_if {|robot| robot['id'] == id}
    end
  end

  def find_by_name(name)
    all.find do |robot|
      robot.name.downcase.include?(name.downcase)
    end
  end

  def delete_all
    database.transaction do
      database['robots'] = []
      database['total'] = 0
    end
  end

end
