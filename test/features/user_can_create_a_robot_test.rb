require_relative "../test_helper"

class UserCanCreateARobotTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_create_a_robot
    visit '/'
    click_link("New")
    assert_equal "/robots/new", current_path

    fill_in("robot[name]", with: "Gustoo")
    fill_in("robot[city]", with: "Los Angeles")
    click_button("submit")
    assert_equal "/robots", current_path
    page.has_content?('Gustoo') #askkkkk!!!
  end
end
