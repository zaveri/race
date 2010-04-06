class OrganizationsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  

  # render new.html.erb
  def new
    @organization = Organization.new
  end
 
  def create
    logout_keeping_session!
    @organization = Organization.new(params[:organization])
    success = @organization && @organization.save
    if success && @organization.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_organization = @organization # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!"
    else
      flash[:error] = "We couldn't create your account, sorry."
      render :action => 'new'
    end
  end
  

end
