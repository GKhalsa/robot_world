require_relative "../test_helper"

class RobotWorldTest < Minitest::Test
  include TestHelpers

  def test_can_we_create_a_robot
    create_robot
    id = id_helper(1)
    robot = robot_world.find(id)

    assert_equal "Robo 1", robot.name
    assert_equal "Los Angeles 1", robot.city
    assert_equal "California 1", robot.state
    assert_equal "1991-4-7", robot.birthdate
    assert_equal "2011-4-7", robot.date_hired
    assert_equal "Computer Lab 1", robot.department
  end

  def test_we_can_list_all_the_robots
    create_robot
    assert_equal 2, robot_world.all.count

    id_1 = id_helper(1)
    id_2 = id_helper(2)

    robot1 = robot_world.find(id_1)
    robot2 = robot_world.find(id_2)

    assert_equal "Robo 1", robot1.name
    assert_equal "Robo 2", robot2.name
  end

  def test_we_can_update_a_robot
    create_robot
    assert_equal 2, robot_world.all.count
    id = id_helper(1)
    robot = robot_world.find(id)

    assert_equal "Robo 1", robot.name
    assert_equal "Los Angeles 1", robot.city
    assert_equal "California 1", robot.state

    robot_world.update(id, {
                name: "Bender",
                city: "Astral 9-ipz",
               state: "non changing"
      })

    robot = robot_world.find(id)

    assert_equal "Bender", robot.name
    assert_equal "Astral 9-ipz", robot.city
    assert_equal "non changing", robot.state
  end

  def test_we_can_find_by_id
    create_robot(3)
    id_1 = id_helper(1)
    id_2 = id_helper(2)
    id_3 = id_helper(3)
    robo1 = robot_world.find(id_1)
    robo2 = robot_world.find(id_2)
    robo3 = robot_world.find(id_3)

    assert_equal "Robo 1", robo1.name
    assert_equal "Robo 2", robo2.name
    assert_equal "Robo 3", robo3.name
  end

  def test_we_can_delete_by_id
    create_robot(4)
    assert robot_world.all.any? {|robot| robot.name == 'Robo 1'}
    id = id_helper(1)
    robot_world.delete(id)

    refute robot_world.all.any? {|robot| robot.name == 'Robo 1'}
  end

  def test_can_find_robots_by_name_fragment
    create_robot
    robots = robot_world.find_by_name('rOb')

    assert_equal 2, robots.count
    assert_equal "Robo 1", robots[0].name
    assert_equal "Robo 2", robots[1].name
  end

  def test_average_age
    create_robot

    assert_equal 24.5, robot_world.average_age
  end

  def test_hirings_by_year
    create_robot

    assert_equal({2011=>1, 2012=>1}, robot_world.hired_by_year)
  end

  def test_robots_per_dept
    create_robot

    assert_equal({"Computer Lab 1"=>1, "Computer Lab 2"=>1}, robot_world.robots_per_dept)
  end

  def test_robots_per_city
    create_robot

    assert_equal({"Los Angeles 1"=>1, "Los Angeles 2"=>1}, robot_world.robots_per_city)
  end

  def test_robots_per_state
    create_robot

    assert_equal({"California 1"=>1, "California 2"=>1},robot_world.robots_per_state)
  end

end
