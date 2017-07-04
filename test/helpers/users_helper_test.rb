require 'test_helper'

class UsersHelperTest < ActionView::TestCase
  
  test "gravatar_for takes optional size" do
    user = User.new(fname:"John", lname:"Jacobs", email:"john.jacobs@gmail.com", password:"password", password_confirmation:"password")
    link = gravatar_for(user, size: 50 )
    gravatar_hash= Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_hash}?s=50"
    assert_equal link, "<img alt=\"#{user.full_name}\" class=\"gravatar\" src=\"#{gravatar_url}\" />", link
  end
end