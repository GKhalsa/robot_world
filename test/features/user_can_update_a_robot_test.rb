require_relative "../test_helper"

class UserCanUpdateARobotTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_update_a_robot
    create_robot(1)
    visit '/robots'
    assert page.has_content?('Robo 1')
    refute page.has_content?('Wwow')

    find('a[href="robots/1/edit"]').click
    assert_equal "/robots/1/edit", current_path
    fill_in("robot[name]", with: "Wwow")
    click_button("submit")
    assert_equal "/robots", current_path

    refute page.has_content?('Robo 1')
    assert page.has_content?('Wwow')
  end


end
