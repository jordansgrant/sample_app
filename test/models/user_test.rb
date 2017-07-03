require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(fname: "Example", lname: "User", email: "example.user@domain.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid user" do
      assert @user.valid?
  end

  test "fname should be present" do
      temp = @user
      temp.fname = "           "
      assert_not temp.valid?
  end

  test "lname should be present" do
      temp = @user
      temp.lname = "           "
      assert_not temp.valid?
  end

  test "email should be present" do
    temp = @user
    temp.email = "    "
    assert_not temp.valid?
  end

  test "fname should not be too long" do
    temp = @user
    temp.fname = "a" * 26
    assert_not temp.valid?
  end
  
  test "lname should not be too long" do
    temp = @user
    temp.lname = "a" * 26
    assert_not temp.valid?
  end
  
  test "email should not be too long" do
    temp = @user
    temp.email = "a" * 245 + "@example.com"
    assert_not temp.valid?
  end

  test "email is unique" do
    duplicate = @user.dup
    duplicate.email.upcase
    @user.save
    assert_not duplicate.valid?
  end

  test "email has proper format" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.com alice+bob@baz.edu]
	invalid_addresses = %w[userexample.com USER@foo @foo.bar.org
                          alice+bob@baz(hello).cn #@%^%#$@#$@#.com]
	valid_addresses.each do |valid_addr|
		@user.email = valid_addr
		assert @user.valid?, "#{valid_addr} should be valid"
	end
	
	invalid_addresses.each do |invalid_addr|
		@user.email = invalid_addr
		assert_not @user.valid?, "#{invalid_addr} should be invalid"
	end
  end
  
  test "email should be downcased" do
    temp = @user
    temp.email = "EXAMPLE@DOMAIN.COM"
    temp.save

    temp.reload.email

    assert_equal temp.email, "example@domain.com"
  end

  test "password not blank" do
    temp = @user
    temp.password = temp.password_confirmation = " " * 6
    assert_not temp.valid?
  end

  test "password is long enough" do
    temp = @user
    temp.password = temp.password_confirmation = "a" * 5
    assert_not temp.valid?
  end
end
