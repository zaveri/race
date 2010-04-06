require File.dirname(__FILE__) + '/../test_helper'

class OrganizationTest < ActiveSupport::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead.
  # Then, you can remove it from this and the functional test.
  include AuthenticatedTestHelper

  def test_should_create_organization
    assert_difference 'Organization.count' do
      organization = create_organization
      assert !organization.new_record?, "#{organization.errors.full_messages.to_sentence}"
    end
  end

  def test_should_require_login
    assert_no_difference 'Organization.count' do
      u = create_organization(:login => nil)
      assert u.errors.on(:login)
    end
  end

  def test_should_require_password
    assert_no_difference 'Organization.count' do
      u = create_organization(:password => nil)
      assert u.errors.on(:password)
    end
  end

  def test_should_require_password_confirmation
    assert_no_difference 'Organization.count' do
      u = create_organization(:password_confirmation => nil)
      assert u.errors.on(:password_confirmation)
    end
  end

  def test_should_require_email
    assert_no_difference 'Organization.count' do
      u = create_organization(:email => nil)
      assert u.errors.on(:email)
    end
  end

  def test_should_reset_password
    organization = Organization.make
    organization.update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal organization, Organization.authenticate(organization.login, 'new password')
  end

  def test_should_not_rehash_password
    organization = Organization.make    
    organization.update_attributes(:login => 'quentin2')
    assert_equal organization, Organization.authenticate('quentin2', organization.password)
  end

  def test_should_authenticate_organization
    organization = Organization.make    
    assert_equal organization, Organization.authenticate(organization.login, organization.password)
  end

  def test_should_set_remember_token
    organization = Organization.make    
    organization.remember_me
    assert_not_nil organization.remember_token
    assert_not_nil organization.remember_token_expires_at
  end

  def test_should_unset_remember_token
    organization = Organization.make    
    organization.remember_me
    assert_not_nil organization.remember_token
    organization.forget_me
    assert_nil organization.remember_token
  end

  def test_should_remember_me_for_one_week
    organization = Organization.make    
    before = 1.week.from_now.utc
    organization.remember_me_for 1.week
    after = 1.week.from_now.utc
    assert_not_nil organization.remember_token
    assert_not_nil organization.remember_token_expires_at
    assert organization.remember_token_expires_at.between?(before, after)
  end

  def test_should_remember_me_until_one_week
    time = 1.week.from_now.utc
    organization = Organization.make    
    organization.remember_me_until time
    assert_not_nil organization.remember_token
    assert_not_nil organization.remember_token_expires_at
    assert_equal organization.remember_token_expires_at, time
  end

  def test_should_remember_me_default_two_weeks
    before = 2.weeks.from_now.utc
    organization = Organization.make    
    organization.remember_me
    after = 2.weeks.from_now.utc
    assert_not_nil organization.remember_token
    assert_not_nil organization.remember_token_expires_at
    assert organization.remember_token_expires_at.between?(before, after)
  end

protected
  def create_organization(options = {})
    record = Organization.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    record.save
    record
  end
end
