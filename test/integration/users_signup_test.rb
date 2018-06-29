require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path,  params: { user: { name:  "",
                                   email: "user@invalid",
                                   password:              "foo",
                                   password_confirmation: "bar" } 
                               	 }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
  	get signup_path
  	assert_difference "User.count" do
      post signup_path params: { user: { name: "Hiro", 
      									 email: "hiro@winner.com",
      									 password: "Hiro8023ZeroTwo",
      									 password_confirmation: "Hiro8023ZeroTwo" }
  								}
  	end
  	follow_redirect!
    assert_template 'users/show'
    assert_not flash.blank?
  end

end
