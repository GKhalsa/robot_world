ENV['RACK_ENV'] ||= "test"

require File.expand_path('../../config/environment', __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'tilt/erb'

Capybara.app = RobotWorldApp

module TestHelpers

  def teardown
    robot_world.delete_all
    super
  end

  def robot_world
    database = YAML::Store.new('db/robot_world_test')
    @robot_world ||= RobotWorld.new(database)
  end

  def create_robot(num = 2)
    num.times do |i|
      robot_world.create({
                  name: "Robo #{i + 1}",
                  city: "Los Angeles #{i + 1}",
                 state: "California #{i + 1}",
             birthdate: "January #{i + 1}",
            date_hired: "March #{i + 1}",
            department: "Computer Lab #{i + 1}"
                        })
    end
  end

end
