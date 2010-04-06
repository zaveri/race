module AuthenticatedTestHelper
  def log_in
    organization = Organization.make
    @request.session[:organization_id] = organization.id
  end

  def authorize
    organization = Organization.make
    @request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Basic.encode_credentials(organization.login, organization.password)
  end
  
end
