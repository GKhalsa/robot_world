require_relative '../test_helper'

class UserCanDeleteARobotTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_delete_a_robot
    create_robot(1)
    visit '/robots'
    assert_equal '/robots', current_path

    assert page.has_content?('Robo 1')
    click_button("delete")
    refute page.has_content?('Robo 1')
    assert '/robots', current_path
  end
end
