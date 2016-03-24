require_relative '../test_helper'

class RobotTest < Minitest::Test
  include TestHelpers

  def test_can_create_a_robot
    create_robot(1)
    robot = robot_world.find(1)
    assert_equal "Robo 1", robot.name
    assert_equal "Los Angeles 1", robot.city
    assert_equal "California 1", robot.state
    assert_equal "January 1", robot.birthdate
    assert_equal "March 1", robot.date_hired
    assert_equal "Computer Lab 1", robot.department
  end
end
