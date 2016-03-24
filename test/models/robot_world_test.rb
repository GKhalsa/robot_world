require_relative "../test_helper"

class RobotWorldTest < Minitest::Test
  include TestHelpers

  def test_can_we_create_a_robot
    create_robot
    robot = robot_world.find(1)

    assert_equal "Robo 1", robot.name
    assert_equal "Los Angeles 1", robot.city
    assert_equal "California 1", robot.state
    assert_equal "January 1", robot.birthdate
    assert_equal "March 1", robot.date_hired
    assert_equal "Computer Lab 1", robot.department
  end

  def test_we_can_list_all_the_robots
    create_robot
    assert_equal 2, robot_world.all.count
    robot1 = robot_world.find(1)
    robot2 = robot_world.find(2)
  end

  def test_we_can_update_a_robot
    create_robot
    assert_equal 2, robot_world.all.count
    robot = robot_world.find(1)

    assert_equal "Robo 1", robot.name
    assert_equal "Los Angeles 1", robot.city
    assert_equal "California 1", robot.state

    robot_world.update(1, {
                name: "Bender",
                city: "Astral 9-ipz",
               state: "non changing"
      })

    robot = robot_world.find(1)

    assert_equal "Bender", robot.name
    assert_equal "Astral 9-ipz", robot.city
    assert_equal "non changing", robot.state

  end

  def test_we_can_find_by_id
    create_robot(4)
    robo1 = robot_world.find(1)
    robo2 = robot_world.find(2)
    robo3 = robot_world.find(3)
    robo4 = robot_world.find(4)

    assert_equal "Robo 1", robo1.name
    assert_equal "Robo 2", robo2.name
    assert_equal "Robo 3", robo3.name
    assert_equal "Robo 4", robo4.name
  end

  def test_we_can_delete_by_id
    create_robot(4)
    assert robot_world.all.any? {|robot| robot.name == 'Robo 1'}

    robot_world.delete(1)

    refute robot_world.all.any? {|robot| robot.name == 'Robo 1'}
  end
end
