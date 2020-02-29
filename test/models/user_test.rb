require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "bob", email: "bob@example.com", password: "bob123")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = " "
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    invalid_addresses = %w[bob@example,com bob.org bob.name@example. bobo@bob_bob.com bob@bob+bob.com]
    invalid_addresses.each do |invalid_address| 
      @user.email = invalid_address
      assert_not @user.valid?
    end
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "emails should be saved as lowercase" do 
    mixed_email = "bOb@ExAmPlE.com"
    @user.email = mixed_email
    @user.save 
    assert_equal @user.email.downcase, @user.reload.email
  end

end
