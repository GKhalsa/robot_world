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
    database = Sequel.sqlite('db/robot_world_test.sqlite')
    @robot_world ||= RobotWorld.new(database)
  end

  def id_helper(num)
    num = num - 1
    id = robot_world.all[num].id
  end

  def create_robot(num = 2)
    num.times do |i|
      robot_world.create({
                  name: "Robo #{i + 1}",
                  city: "Los Angeles #{i + 1}",
                 state: "California #{i + 1}",
             birthdate: "199#{+ i + 1}-4-7",
            date_hired: "201#{+ i + 1}-4-7",
            department: "Computer Lab #{i + 1}"
                        })
    end
  end

end
