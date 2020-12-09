
require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "logout layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path

    get contact_path
    assert_select "title", full_title("Contact")
  end

  test "login layout links" do
    log_in_as(@user, remember_me: '0')
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]",'/users/' + @user.id.to_s
    assert_select "a[href=?]",'/users/' + @user.id.to_s + '/edit'
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path

    get contact_path
    assert_select "title", full_title("Contact")
  end


end