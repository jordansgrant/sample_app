require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:jane)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { fname:  "",
                                              lname:  "bar",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
  end
  
  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    fname  = "Foo"
    lname = "Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { fname:  fname,
                                              lname:  lname,
                                              email: email,
                                              password:              "helloworld",
                                              password_confirmation: "helloworld" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal "#{fname} #{lname}",  @user.full_name
    assert_equal email, @user.email
  end
end
